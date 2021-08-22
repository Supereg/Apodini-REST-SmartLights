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
            UserHomeListHandler(userId: $userId)
                .relationship(name: "user", to: User.self)
                .relationship(to: HomeComponent.membersRelationship)
                .relationship(to: HomeComponent.devicesRelationship)

            // TODO self link should ideally point to /homes/{homeId}. https://github.com/Apodini/Apodini/issues/223 point 15.
            HomeCreationHandler(userId: $userId)

            Group($homeId.relationship(name: "home")) {
                UserHomeHandler(userId: $userId, homeId: $homeId)
            }

            Group("primary") { // controls the `primaryHome` of the user
                UserPrimaryHomeHandler(userId: $userId)
                    .destination(of: primaryHome)

                UpdatePrimaryHomeHandler(userId: $userId)
            }
        }
    }
}
