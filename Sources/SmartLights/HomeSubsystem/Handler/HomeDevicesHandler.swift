//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct HomeDevicesHandler: Handler {
    @Throws(.notFound, reason: "Home not found")
    var notFound: ApodiniError

    @Binding
    var homeId: Home.ID

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<[Device]> {
        HomeModel
            .query(on: database)
            .filter(\._$id == homeId)
            .field(\._$id)
            .with(\.$devices)
            .first()
            .unwrap(orError: notFound)
            .map { homeModel in
                homeModel.devices.map { deviceModel in
                    Device(from: deviceModel)
                }
            }
    }
}
