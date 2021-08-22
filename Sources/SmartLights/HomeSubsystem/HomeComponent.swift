//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini

struct HomeComponent: Component {
    @PathParameter(identifying: Home.self)
    var homeId: Home.ID

    static var membersRelationship = Relationship(name: "members")
    static var devicesRelationship = Relationship(name: "devices")

    var content: some Component {
        Group("home".relationship(name: "home"), $homeId) {
            HomeHandler(homeId: $homeId)

            HomeDeletionHandler(homeId: $homeId)

            // Feature: add a handler to rename a Home

            Group("members") {
                HomeMembersHandler(homeId: $homeId)
                    .relationship(name: "user", to: User.self)
                    .destination(of: Self.membersRelationship)

                HomeMembersAddHandler(homeId: $homeId)
                HomeMembersRemoveHandler(homeId: $homeId)
            }

            Group("devices") {
                HomeDevicesHandler(homeId: $homeId)
                    .relationship(name: "device", to: Device.self)
                    .destination(of: Self.devicesRelationship)
            }
        }
    }
}
