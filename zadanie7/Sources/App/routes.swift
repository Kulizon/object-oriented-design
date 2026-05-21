import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: CategoryController())
    try app.register(collection: ProductController())
    try app.register(collection: OrderController())

    app.get { req -> Response in
        req.redirect(to: "/products")
    }
}
