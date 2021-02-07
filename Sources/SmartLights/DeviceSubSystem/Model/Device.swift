//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini
import SemVer

struct Device: Content, Identifiable, WithRelationships {
    let id: Int
    let homeId: Home.ID?

    let name: String

    let firmwareVersion: SemVer
    let serialNumber: String

    let state: DeviceState

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firmwareVersion
        case serialNumber
        case state
    }

    static var relationships: Relationships {
        References<Home>(as: "home", identifiedBy: \.homeId)
    }
}

extension Device {
    init(from model: DeviceModel) {
        guard let id = model.id else {
            fatalError("Device id is not set!")
        }

        self.init(
            id: id,
            homeId: model.$home.id,
            name: model.name,
            firmwareVersion: model.firmwareVersion,
            serialNumber: model.serialNumber,
            state: DeviceState(
                on: model.stateOn,
                brightness: model.stateBrightness
            )
        )
    }
}
