//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import SemVer

struct DeviceSetup: Content, Codable {
    let name: String

    /// Defines the `Home` this device was added to.
    let homeId: Home.ID

    let firmwareVersion: SemVer
    let serialNumber: String
}
