//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import Apodini

struct UserComponent: Component {
    @PathParameter(identifying: User.self)
    var userId: User.ID
    @PathParameter(identifying: UserHome.self)
    var homeId: Home.ID

    let primaryHome = Relationship(name: "homes_primary")

    var content: some Component {
        Group("user".relationship(name: "user")) {
            UserRegistrationHandler() // TODO self link doesn't point to read
                .operation(.create)

            Group($userId.relationship(name: "user")) {
                UserHandler(userId: $userId)
                    .relationship(to: primaryHome)

                UserHomesSubComponent(userId: _userId, primaryHome: primaryHome)
            }
        }
    }
}
