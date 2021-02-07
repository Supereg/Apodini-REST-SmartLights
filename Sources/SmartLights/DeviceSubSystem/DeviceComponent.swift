//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import SemVer

struct DeviceComponent: Component {
    @PathParameter(identifying: Device.self)
    var deviceId: Device.ID

    var content: some Component {
        Group("device".relationship(name: "device")) {
            DeviceSetupHandler()
                .operation(.create)

            Group {
                $deviceId
                    .relationship(name: "device")
            } content: {
                DeviceHandler(deviceId: $deviceId)

                DeviceAssignHomeHandler(deviceId: $deviceId)
                    .operation(.update)
            }
        }
    }
}
