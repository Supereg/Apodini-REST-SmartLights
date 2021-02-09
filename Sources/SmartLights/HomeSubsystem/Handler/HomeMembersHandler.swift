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

    func handle() -> EventLoopFuture<[Member]> {
        HomeModel
            .query(on: database)
            .filter(\._$id == homeId)
            .with(\.$owner)
            .with(\.$members)
            .first()
            .unwrap(orError: notFound)
            .map { (homeModel: HomeModel) in
                var members = homeModel.members.map { userModel in
                    Member(from: userModel)
                }
                members.insert(Member(from: homeModel.owner), at: 0)
                return members
            }
    }
}
