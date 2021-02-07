//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import FluentKit

struct CreateUserMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.user)
            .field(.id, .int, .identifier(auto: true))
            .field("name", .string, .required)
            .field("lastname", .string, .required)
            .field("email", .string, .required)
            .field("phone_number", .string, .required)
            // This is obviously not how you would do passwords.
            // See https://auth0.com/blog/adding-salt-to-hashing-a-better-way-to-store-passwords/
            // on how to properly hash and salt passwords in a real system.
            .field("password", .string, .required)
            .field("profile_pic", .int, .references(Schema.media, "id", onDelete: .setNull, onUpdate: .cascade))
            .field("primary_home", .int, .references(Schema.home, "id", onDelete: .setNull, onUpdate: .cascade))
            .unique(on: "email")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.user)
            .delete()
    }
}
