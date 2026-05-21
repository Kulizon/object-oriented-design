import Vapor
import Fluent
import Redis

struct CategoryController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let categories = routes.grouped("categories")
        categories.get(use: index)
        categories.get("create", use: createForm)
        categories.post(use: create)
        categories.get(":id", "edit", use: editForm)
        categories.post(":id", "edit", use: update)
        categories.post(":id", "delete", use: delete)
    }

    // MARK: - Cache helpers

    private func cacheCategories(_ categories: [Category], on req: Request) async {
        let data = try? JSONEncoder().encode(categories)
        if let data = data, let json = String(data: data, encoding: .utf8) {
            _ = try? await req.redis.set("categories:all", to: json).get()
            _ = try? await req.redis.expire("categories:all", after: .seconds(60)).get()
        }
    }

    private func getCachedCategories(on req: Request) async -> [Category]? {
        guard let json = try? await req.redis.get("categories:all", as: String.self).get(),
              let data = json.data(using: .utf8),
              let categories = try? JSONDecoder().decode([Category].self, from: data) else {
            return nil
        }
        return categories
    }

    private func invalidateCache(on req: Request) async {
        _ = try? await req.redis.delete("categories:all").get()
    }

    // MARK: - CRUD

    func index(req: Request) async throws -> View {
        let categories: [Category]
        if let cached = await getCachedCategories(on: req) {
            categories = cached
        } else {
            categories = try await Category.query(on: req.db).all()
            await cacheCategories(categories, on: req)
        }
        return try await req.view.render("categories/index", ["categories": categories])
    }

    func createForm(req: Request) async throws -> View {
        try await req.view.render("categories/create")
    }

    func create(req: Request) async throws -> Response {
        let input = try req.content.decode(CategoryInput.self)
        let category = Category(name: input.name)
        try await category.save(on: req.db)
        await invalidateCache(on: req)
        return req.redirect(to: "/categories")
    }

    func editForm(req: Request) async throws -> View {
        guard let category = try await Category.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return try await req.view.render("categories/edit", ["category": category])
    }

    func update(req: Request) async throws -> Response {
        guard let category = try await Category.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let input = try req.content.decode(CategoryInput.self)
        category.name = input.name
        try await category.save(on: req.db)
        await invalidateCache(on: req)
        return req.redirect(to: "/categories")
    }

    func delete(req: Request) async throws -> Response {
        guard let category = try await Category.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await category.delete(on: req.db)
        await invalidateCache(on: req)
        return req.redirect(to: "/categories")
    }
}

struct CategoryInput: Content {
    var name: String
}
