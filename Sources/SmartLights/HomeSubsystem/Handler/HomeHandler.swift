//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct HomeHandler: Handler {
    @Throws(.notFound, reason: "Home not found")
    var notFound: ApodiniError

    @Binding
    var homeId: Home.ID

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<Home> {
        HomeModel
            .query(on: database)
            .filter(\._$id == homeId)
            .with(\.$members)
            .with(\.$members.$pivots)
            .first()
            .unwrap(orError: notFound)
            .map { homeModel in
                Home(from: homeModel)
            }
    }
}
