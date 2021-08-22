//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import FluentKit

struct HomeCreationHandler: Handler {
    @Throws(.notFound, reason: "User not found")
    var userNotFound: ApodiniError

    @Binding
    var userId: User.ID
    @Parameter
    var createdHome: HomeCreation

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<UserHome> {
        UserModel
            .find(userId, on: database)
            .unwrap(orError: userNotFound)
            .flatMap { _ in
                let home = HomeModel(from: createdHome)
                home.$owner.id = userId

                return home
                    .save(on: database)
                    .map {
                        UserHome(user: userId, from: home)
                    }
            }
    }

    var metadata: Metadata {
        Operation(.create)
    }
}
