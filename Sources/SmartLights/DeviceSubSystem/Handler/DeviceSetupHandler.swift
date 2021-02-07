//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct DeviceSetupHandler: Handler {
    @Throws(.notFound, reason: "Home not found")
    var homeNotFound: ApodiniError

    @Parameter
    var deviceSetup: DeviceSetup

    @Environment(\.database)
    var database: Database

    func handle() -> EventLoopFuture<Device> {
        let device = DeviceModel(
            name: deviceSetup.name,
            firmwareVersion: deviceSetup.firmwareVersion,
            serialNumber: deviceSetup.serialNumber,
            stateOn: false,
            stateBrightness: 0
        )

        return HomeModel
            .find(deviceSetup.homeId, on: database)
            .unwrap(orError: homeNotFound)
            .flatMap { _ in
                device.$home.id = deviceSetup.homeId

                return device
                    .save(on: database)
                    .map {
                        Device(from: device)
                    }
            }
    }
}
