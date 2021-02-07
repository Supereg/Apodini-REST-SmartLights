//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import Apodini

struct User: Content, Identifiable, WithRelationships {
    let id: Int

    let name: String
    let lastname: String
    let email: String
    let phoneNumber: String
    
    let primaryHome: Home.ID?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastname
        case email
        case phoneNumber
    }

    static var relationships: Relationships {
        References<Home>(as: "primaryHome", identifiedBy: \.primaryHome)
    }
}

extension User {
    init(from: UserModel) {
        guard let id = from.id else {
            fatalError("Unable to initialize `User` from `UserModel` without ID")
        }

        self.init(
            id: id,
            name: from.name,
            lastname: from.lastname,
            email: from.email,
            phoneNumber: from.phoneNumber,
            primaryHome: from.$primaryHome.id
        )
    }
}
