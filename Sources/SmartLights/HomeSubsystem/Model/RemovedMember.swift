//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini

struct RemovedMember: Content, Codable {
    let userId: User.ID
    var removed = true

    static var metadata: Metadata {
        Inherits<User>(identifiedBy: \.userId)
    }
}

extension RemovedMember {
    init(from model: UserModel) {
        guard let id = model.id else {
            fatalError("User id not present!")
        }

        self.init(userId: id)
    }
}
