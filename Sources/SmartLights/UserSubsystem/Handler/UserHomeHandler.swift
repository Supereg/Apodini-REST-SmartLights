//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct UserHomeHandler: Handler {
    @Throws(.notFound, reason: "UserHome not found")
    var notFound: ApodiniError

    @Binding
    var userId: User.ID
    @Binding
    var homeId: Home.ID

    @Environment(\.database)
    var database: Database
    
    func handle() -> EventLoopFuture<UserHome> {
        HomeMembersModel
            .query(on: database)
            .filter(\.$user.$id == userId)
            .filter(\.$home.$id == homeId)
            .with(\.$home) { home in
                home.with(\.$members)
            }
            .first()
            .unwrap(orError: notFound)
            .map { homeMember in
                UserHome(from: homeMember)
            }
    }
}
