//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct UserPrimaryHomeHandler: Handler {
    @Throws(.notFound, reason: "User not found")
    var userNotFound: ApodiniError
    @Throws(.notFound, reason: "User has no primary home set")
    var noPrimaryHome: ApodiniError

    @Binding
    var userId: User.ID

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<UserHome> {
        UserModel
            .query(on: database)
            .filter(\._$id == userId)
            .with(\.$primaryHome)
            .first()
            .unwrap(orError: userNotFound)
            .flatMapThrowing { userModel in
                guard let primaryHome = userModel.primaryHome else {
                    throw noPrimaryHome
                }

                return UserHome(user: userId, from: primaryHome)
            }
    }
}
