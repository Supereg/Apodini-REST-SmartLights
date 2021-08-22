//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini

struct Member: Content, Identifiable {
    let id: User.ID

    let name: String
    let lastname: String
    let email: String

    static var metadata: Metadata {
        Inherits<User>()
    }
}

extension Member {
    init(from: UserModel) {
        guard let id = from.id else {
            fatalError("Unable to initialize `User` from `UserModel` without ID")
        }

        self.init(
            id: id,
            name: from.name,
            lastname: from.lastname,
            email: from.email
        )
    }
}
