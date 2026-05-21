import Vapor
import Fluent
import Redis

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: index)
        products.get("create", use: createForm)
        products.post(use: create)
        products.get(":id", "edit", use: editForm)
        products.post(":id", "edit", use: update)
        products.post(":id", "delete", use: delete)
    }

    private func invalidateCache(on req: Request) async {
        _ = try? await req.redis.delete("products:all").get()
    }

    func index(req: Request) async throws -> View {
        let products = try await Product.query(on: req.db).with(\.$category).all()
        let categories = try await Category.query(on: req.db).all()
        return try await req.view.render("products/index", ProductsContext(products: products, categories: categories))
    }

    func createForm(req: Request) async throws -> View {
        let categories = try await Category.query(on: req.db).all()
        return try await req.view.render("products/create", ["categories": categories])
    }

    func create(req: Request) async throws -> Response {
        let input = try req.content.decode(ProductInput.self)
        let product = Product(name: input.name, price: input.price, categoryID: input.categoryID)
        try await product.save(on: req.db)
        await invalidateCache(on: req)
        return req.redirect(to: "/products")
    }

    func editForm(req: Request) async throws -> View {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let categories = try await Category.query(on: req.db).all()
        return try await req.view.render("products/edit", ProductEditContext(product: product, categories: categories))
    }

    func update(req: Request) async throws -> Response {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let input = try req.content.decode(ProductInput.self)
        product.name = input.name
        product.price = input.price
        product.$category.id = input.categoryID
        try await product.save(on: req.db)
        await invalidateCache(on: req)
        return req.redirect(to: "/products")
    }

    func delete(req: Request) async throws -> Response {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        await invalidateCache(on: req)
        return req.redirect(to: "/products")
    }
}

struct ProductInput: Content {
    var name: String
    var price: Double
    var categoryID: UUID

    enum CodingKeys: String, CodingKey {
        case name, price
        case categoryID = "category_id"
    }
}

struct ProductsContext: Encodable {
    var products: [Product]
    var categories: [Category]
}

struct ProductEditContext: Encodable {
    var product: Product
    var categories: [Category]
}
