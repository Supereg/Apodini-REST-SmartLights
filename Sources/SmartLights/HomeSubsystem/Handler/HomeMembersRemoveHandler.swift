//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct HomeMembersRemoveHandler: Handler {
    @Throws(.notFound, reason: "Home was not found")
    var homeNotFound: ApodiniError
    @Throws(.notFound, reason: "Member was not found")
    var userNotFound: ApodiniError

    @Binding
    var homeId: Home.ID
    @Parameter
    var removedMember: MemberSelection

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<RemovedMember> {
        HomeModel
            .find(homeId, on: database)
            .unwrap(orError: homeNotFound)
            .flatMap { homeModel in
                UserModel
                    .find(removedMember.userId, on: database)
                    .unwrap(orError: userNotFound)
                    .flatMap { userModel in
                        homeModel.$members
                            .detach(userModel, on: database)
                            .map {
                                RemovedMember(from: userModel)
                            }
                    }
            }
    }

    var metadata: Metadata {
        Operation(.delete)
    }
}
