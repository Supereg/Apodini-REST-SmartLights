//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct UserRegistrationHandler: Handler {
    @Parameter
    var registration: UserRegistration

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<User> {
        let user = UserModel(from: registration)

        return user
            .save(on: database)
            .map {
                User(from: user)
            }
    }
}
