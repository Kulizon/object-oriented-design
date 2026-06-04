import Vapor

enum RoutePaths {
    static let categories = "categories"
    static let products = "products"
    static let orders = "orders"
}

func routes(_ app: Application) throws {
    try app.register(collection: CategoryController())
    try app.register(collection: ProductController())
    try app.register(collection: OrderController())

    app.get { req -> Response in
        req.redirect(to: "/" + RoutePaths.products)
    }
}
