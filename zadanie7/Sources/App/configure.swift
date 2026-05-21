import Vapor
import Fluent
import FluentSQLiteDriver
import Leaf
import Redis

func configure(_ app: Application) async throws {
    // Database
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    // Redis
    if let redisURL = Environment.get("REDIS_URL") {
        try app.redis.configuration = .init(url: redisURL)
    } else {
        app.redis.configuration = try .init(hostname: "127.0.0.1", port: 6379)
    }

    // Leaf
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease

    // Migrations
    app.migrations.add(CreateCategory())
    app.migrations.add(CreateProduct())
    app.migrations.add(CreateOrder())
    try await app.autoMigrate()

    // Routes
    try routes(app)
}
