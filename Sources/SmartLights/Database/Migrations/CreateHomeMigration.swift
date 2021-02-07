//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import FluentKit

struct CreateHomeMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.home)
            .field(.id, .int, .identifier(auto: true))
            .field("name", .string, .required)
            .field("owner_id", .int, .references(Schema.user, "id", onDelete: .cascade, onUpdate: .cascade))
            .field("street", .string, .required)
            .field("zip_code", .string, .required)
            .field("city", .string, .required)
            .field("country", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.home)
            .delete()
    }
}
