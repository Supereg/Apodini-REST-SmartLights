//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct DeviceAssignHomeHandler: Handler {
    @Throws(.notFound, reason: "Device not found")
    var notFound: ApodiniError
    @Throws(.notFound, reason: "Home not found")
    var homeNotFound: ApodiniError

    @Parameter
    var deviceId: Device.ID
    @Parameter
    var homeAssignment: DeviceHomeAssignment

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<Device> {
        DeviceModel
            .find(deviceId, on: database)
            .unwrap(orError: notFound)
            .flatMap { deviceModel in
                HomeModel
                    .find(homeAssignment.homeId, on: database)
                    .unwrap(orError: homeNotFound)
                    .flatMap { _ in
                        deviceModel.$home.id = homeAssignment.homeId

                        return deviceModel
                            .save(on: database)
                            .map {
                                Device(from: deviceModel)
                            }
                    }
            }
    }
}
