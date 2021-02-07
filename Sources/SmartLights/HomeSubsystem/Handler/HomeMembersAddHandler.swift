//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct HomeMembersAddHandler: Handler {
    @Throws(.notFound, reason: "Home was not found")
    var homeNotFound: ApodiniError
    @Throws(.notFound, reason: "Member was not found")
    var userNotFound: ApodiniError

    @Parameter
    var homeId: Home.ID
    @Parameter
    var addedMember: MemberSelection

    @Environment(\.database)
    var database: Database

    @Environment(\.eventLoopGroup)
    var eventLoop: EventLoopGroup

    func handle() -> EventLoopFuture<Member> {
        HomeModel
            .find(homeId, on: database)
            .unwrap(orError: homeNotFound)
            .flatMap { homeModel in
                UserModel
                    .find(addedMember.userId, on: database)
                    .unwrap(orError: userNotFound)
                    .flatMap { userModel in
                        homeModel.$members
                            .attach(userModel, method: .ifNotExists, on: database)
                            .map {
                                Member(from: userModel)
                            }
                    }
            }
    }
}
