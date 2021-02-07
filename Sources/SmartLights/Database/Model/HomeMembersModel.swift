//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import FluentKit

final class HomeMembersModel: Model {
    static let schema: String = Schema.homeMembers

    @ID(custom: .id, generatedBy: .database)
    var id: Int?

    @Parent(key: "user_id")
    var user: UserModel

    @Parent(key: "home_id")
    var home: HomeModel


    init() {}

    init(id: Int? = nil, home: HomeModel, user: UserModel) throws {
        self.id = id
        self.$home.id = try home.requireID()
        self.$user.id = try user.requireID()
    }
}
