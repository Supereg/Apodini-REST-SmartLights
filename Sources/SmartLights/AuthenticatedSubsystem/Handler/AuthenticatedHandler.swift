//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct AuthenticatedHandler: Handler {
    @Throws(.serverError, reason: "Internal Server Error: Missing authenticated user!")
    var serverError: ApodiniError

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<User> {
        UserModel
            .find(3, on: database) // simulation authenticated user by pre selecting user 3
            .unwrap(orError: serverError)
            .map { userModel in
                User(from: userModel)
            }
    }
}
