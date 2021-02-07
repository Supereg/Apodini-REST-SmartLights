//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import FluentKit

struct DeviceHandler: Handler {
    @Throws(.notFound, reason: "Device not found")
    var notFound: ApodiniError

    @Parameter
    var deviceId: Device.ID

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<Device> {
        DeviceModel
            .find(deviceId, on: database)
            .unwrap(orError: notFound)
            .map { deviceModel in
                Device(from: deviceModel)
            }
    }
}
