//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import FluentKit

struct CreateMediaMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.media)
            .field(.id, .int, .identifier(auto: true))
            .field("image_data", .data, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.media)
            .delete()
    }
}
