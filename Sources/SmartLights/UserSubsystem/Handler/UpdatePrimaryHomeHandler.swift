//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct UpdatePrimaryHomeHandler: Handler {
    @Throws(.notFound, reason: "Home not found")
    var homeNotFound: ApodiniError

    @Parameter
    var userId: User.ID
    @Parameter
    var primaryHomeUpdate: PrimaryHomeUpdate


    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<UserHome> {
        HomeModel
            .find(primaryHomeUpdate.homeId, on: database)
            .unwrap(orError: homeNotFound)
            .flatMap { homeModel in
                UserModel
                    .query(on: database)
                    .filter(\._$id == userId)
                    .set(\.$primaryHome.$id, to: primaryHomeUpdate.homeId)
                    .update()
                    .map {
                        UserHome(user: userId, from: homeModel)
                    }
            }
    }
}
