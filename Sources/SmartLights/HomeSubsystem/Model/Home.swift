//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import Apodini

struct Home: Content, Identifiable {
    let id: Int

    /// The owner of the Home
    let owner: User.ID

    let name: String

    let street: String
    let zipCode: String
    let city: String
    let country: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case street
        case zipCode
        case city
        case country
    }

    static var metadata: Metadata {
        References<User>(as: "owner", identifiedBy: \.owner)
    }
}

extension Home {
    init(from model: HomeModel) {
        guard let id = model.id else {
            fatalError("Id not set!")
        }

        self.init(
            id: id,
            owner: model.$owner.id,
            name: model.name,
            street: model.street,
            zipCode: model.zipCode,
            city: model.city,
            country: model.country
        )
    }
}
