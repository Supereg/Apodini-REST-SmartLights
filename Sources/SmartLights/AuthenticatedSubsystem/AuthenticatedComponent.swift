//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import Apodini

struct AuthenticatedComponent: Component {
    var content: some Component {
        Group("authenticated".relationship(name: "authenticated")) {
            AuthenticatedHandler()
        }
    }
}
