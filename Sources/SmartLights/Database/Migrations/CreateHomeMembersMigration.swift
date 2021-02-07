//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import FluentKit

struct CreateHomeMemberMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.homeMembers)
            .field(.id, .int, .identifier(auto: true))
            .field("home_id", .int, .references(Schema.user, .id, onDelete: .cascade, onUpdate: .cascade))
            .field("user_id", .int, .references(Schema.user, .id, onDelete: .cascade, onUpdate: .cascade))
            .unique(on: "home_id", "user_id")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.homeMembers)
            .delete()
    }
}
