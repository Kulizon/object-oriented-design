import Fluent
import Vapor

final class Order: Model, Content, @unchecked Sendable {
    static let schema = "orders"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "customer_name")
    var customerName: String

    @Field(key: "quantity")
    var quantity: Int

    @Parent(key: "product_id")
    var product: Product

    init() {}

    init(id: UUID? = nil, customerName: String, quantity: Int, productID: UUID) {
        self.id = id
        self.customerName = customerName
        self.quantity = quantity
        self.$product.id = productID
    }
}

struct CreateOrder: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("orders")
            .id()
            .field("customer_name", .string, .required)
            .field("quantity", .int, .required)
            .field("product_id", .uuid, .required, .references("products", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("orders").delete()
    }
}
