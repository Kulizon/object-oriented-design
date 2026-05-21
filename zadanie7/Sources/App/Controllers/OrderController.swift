import Vapor
import Fluent
import Redis

struct OrderController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let orders = routes.grouped("orders")
        orders.get(use: index)
        orders.get("create", use: createForm)
        orders.post(use: create)
        orders.get(":id", "edit", use: editForm)
        orders.post(":id", "edit", use: update)
        orders.post(":id", "delete", use: delete)
    }

    private func invalidateCache(on req: Request) async {
        _ = try? await req.redis.delete("orders:all").get()
    }

    func index(req: Request) async throws -> View {
        let orders = try await Order.query(on: req.db).with(\.$product).all()
        return try await req.view.render("orders/index", ["orders": orders])
    }

    func createForm(req: Request) async throws -> View {
        let products = try await Product.query(on: req.db).all()
        return try await req.view.render("orders/create", ["products": products])
    }

    func create(req: Request) async throws -> Response {
        let input = try req.content.decode(OrderInput.self)
        let order = Order(customerName: input.customerName, quantity: input.quantity, productID: input.productID)
        try await order.save(on: req.db)
        await invalidateCache(on: req)
        return req.redirect(to: "/orders")
    }

    func editForm(req: Request) async throws -> View {
        guard let order = try await Order.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let products = try await Product.query(on: req.db).all()
        return try await req.view.render("orders/edit", OrderEditContext(order: order, products: products))
    }

    func update(req: Request) async throws -> Response {
        guard let order = try await Order.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let input = try req.content.decode(OrderInput.self)
        order.customerName = input.customerName
        order.quantity = input.quantity
        order.$product.id = input.productID
        try await order.save(on: req.db)
        await invalidateCache(on: req)
        return req.redirect(to: "/orders")
    }

    func delete(req: Request) async throws -> Response {
        guard let order = try await Order.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await order.delete(on: req.db)
        await invalidateCache(on: req)
        return req.redirect(to: "/orders")
    }
}

struct OrderInput: Content {
    var customerName: String
    var quantity: Int
    var productID: UUID

    enum CodingKeys: String, CodingKey {
        case customerName = "customer_name"
        case quantity
        case productID = "product_id"
    }
}

struct OrderEditContext: Encodable {
    var order: Order
    var products: [Product]
}
