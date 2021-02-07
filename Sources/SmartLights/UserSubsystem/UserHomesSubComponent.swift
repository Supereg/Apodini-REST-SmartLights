//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini

struct UserHomesSubComponent: Component {
    @PathParameter
    var userId: User.ID
    @PathParameter(identifying: UserHome.self)
    var homeId: Home.ID

    var primaryHome: Relationship

    var content: some Component {
        Group("homes") {
            UserHomeListHandler(userId: $userId) // TODO members relationship
                .relationship(name: "user", to: User.self)

            HomeCreationHandler(userId: $userId) // TODO self links (like for the user registration Handler)
                .operation(.create)

            Group($homeId.relationship(name: "home")) {
                UserHomeHandler(userId: $userId, homeId: $homeId)
            }

            Group("primary") { // controls the `primaryHome` of the user
                UserPrimaryHomeHandler(userId: $userId)
                    .destination(of: primaryHome)

                UpdatePrimaryHomeHandler(userId: $userId)
                    .operation(.update)
                // TODO Relationship could have multiple destinations?
            }
        }
    }
}
