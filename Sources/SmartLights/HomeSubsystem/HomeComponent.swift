//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini

struct HomeComponent: Component {
    @PathParameter(identifying: Home.self)
    var homeId: Home.ID

    var content: some Component {
        Group("home".relationship(name: "home"), $homeId) {
            HomeHandler(homeId: $homeId)

            HomeDeletionHandler(homeId: $homeId)
                .operation(.delete)

            // Feature: add a handler to rename a Home

            Group("members") {
                HomeMembersHandler(homeId: $homeId)
                    .relationship(name: "user", to: User.self)

                HomeMembersAddHandler(homeId: $homeId)
                    .operation(.update)
                HomeMembersRemoveHandler(homeId: $homeId)
                    .operation(.delete)
            }

            Group("devices") {
                HomeDevicesHandler(homeId: $homeId)
                    .relationship(name: "device", to: Device.self)
            }
        }
    }
}
