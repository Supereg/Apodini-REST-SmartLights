//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import FluentKit
import SemVer

/// Database Model for a Lightbulb device.
final class DeviceModel: Model {
    private(set) static var schema: String = Schema.device

    @ID(custom: .id, generatedBy: .database)
    var id: Int?

    @OptionalParent(key: "home_id")
    var home: HomeModel?

    @Field(key: "name")
    var name: String

    @Field(key: "firmware_version")
    var firmwareVersion: SemanticVersion

    @Field(key: "serial_number")
    var serialNumber: String

    @Field(key: "state_on")
    var stateOn: Bool

    @Field(key: "state_brightness")
    var stateBrightness: UInt8

    init() {}

    init(
        id: Int? = nil,
        name: String,
        firmwareVersion: SemanticVersion,
        serialNumber: String,
        stateOn: Bool,
        stateBrightness: UInt8
    ) {
        self.id = id
        self.name = name
        self.firmwareVersion = firmwareVersion
        self.serialNumber = serialNumber
        self.stateOn = stateOn
        self.stateBrightness = stateBrightness
    }
}
