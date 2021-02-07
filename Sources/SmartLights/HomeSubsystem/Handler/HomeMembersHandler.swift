//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct HomeMembersHandler: Handler {
    @Throws(.notFound, reason: "Home not found")
    var notFound: ApodiniError

    @Parameter
    var homeId: Home.ID

    @Environment(\.database)
    var database: Database

    // TODO maybe also list the owner
    func handle() -> EventLoopFuture<[Member]> {
        HomeModel
            .query(on: database)
            .filter(\._$id == homeId)
            .field(\._$id)
            .with(\.$members)
            .first()
            .unwrap(orError: notFound)
            .map { homeModel in
                homeModel.members.map { userModel in
                    Member(from: userModel)
                }
            }
    }
}
