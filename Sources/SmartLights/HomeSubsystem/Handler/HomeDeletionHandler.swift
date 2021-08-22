//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import FluentKit

struct HomeDeletionHandler: Handler {
    @Binding
    var homeId: Home.ID

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<DeletedHome> {
        // Improvement: once Authentication is supported,
        // very that the requesting client owns the home which is to be deleted
        HomeModel
            .query(on: database)
            .filter(\._$id == homeId)
            .delete()
            .map {
                DeletedHome(id: homeId)
            }
    }

    var metadata: Metadata {
        Operation(.delete)
    }
}
