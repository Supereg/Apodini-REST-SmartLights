//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct UserHandler: Handler {
    @Throws(.notFound, reason: "User not found")
    var notFound: ApodiniError

    @Parameter
    var userId: User.ID

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<User> {
        UserModel
            .find(userId, on: database)
            .unwrap(orError: notFound)
            .map { userModel in
                User(from: userModel)
            }
    }
}
