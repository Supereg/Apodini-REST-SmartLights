//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import FluentKit

struct CreateDeviceMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.device)
            .field(.id, .int, .identifier(auto: true))
            // when the home is deleted, the device is just unassigned and can be reassigned to a home with PUT /device/x/
            .field("home_id", .uuid, .references(Schema.home, "id", onDelete: .setNull, onUpdate: .cascade))
            .field("name", .string, .required)
            .field("firmware_version", .string, .required)
            .field("serial_number", .string, .required)
            .field("state_on", .bool, .required)
            .field("state_brightness", .uint8, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(Schema.device)
            .delete()
    }
}
