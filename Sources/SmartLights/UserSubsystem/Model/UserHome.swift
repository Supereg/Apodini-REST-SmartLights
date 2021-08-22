//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import Apodini

/// Returns `Home` information with the context of a given `User`
struct UserHome: Content, Identifiable {
    /// The `Home` id
    let id: Int
    /// The `User` id for which this `Home` is returned.
    let userId: User.ID
    /// Defines if the given user is the owner of the home
    let ownerId: User.ID
    /// Defines if the given `User` is the owner for the given `Home`
    let isOwner: Bool
    /// The name of the home
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId
        case isOwner
        case name
    }

    static var metadata: Metadata {
        Inherits<Home>() // as `UserHome` conforms to identifiable, it automatically uses \.id

        // TODO currently overwritten by the "owner" reference. See https://github.com/Apodini/Apodini/issues/223 point 9.
        References<User>(as: "user", identifiedBy: \.userId)
        References<User>(as: "owner", identifiedBy: \.ownerId)
    }

    init(id: Int, userId: Int, ownerId: Int, name: String) {
        self.id = id
        self.userId = userId
        self.ownerId = ownerId
        self.isOwner = userId == ownerId
        self.name = name
    }
}


extension UserHome {
    init(user userId: Int, from model: HomeModel) {
        guard let homeId = model.id else {
            fatalError("Loaded HomeModel without id!")
        }

        self.init(id: homeId,
                  userId: userId,
                  ownerId: model.$owner.id,
                  name: model.name)
    }

    init(from: HomeMembersModel) {
        self.init(
            id: from.$home.id,
            userId: from.$user.id,
            ownerId: from.home.$owner.id,
            name: from.home.name
        )
    }
}
