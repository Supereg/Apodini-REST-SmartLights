//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import FluentKit

/// Models a `User` in our database
final class UserModel: Model {
    static let schema: String = Schema.user

    @ID(custom: .id, generatedBy: .database)
    var id: Int?

    @Field(key: "name")
    var name: String
    @Field(key: "lastname")
    var lastname: String
    @Field(key: "email")
    var email: String
    @Field(key: "phone_number")
    var phoneNumber: String

    /// This is obviously not how you would do passwords.
    /// See https://auth0.com/blog/adding-salt-to-hashing-a-better-way-to-store-passwords/
    /// on how to properly hash and salt passwords in a real system.
    @Field(key: "password")
    var password: String

    @OptionalParent(key: "profile_pic")
    var profilePicture: MediaModel?

    @OptionalParent(key: "primary_home")
    var primaryHome: HomeModel?

    /// Array of `HomeModel` where this use is the owner of.
    @Children(for: \.$owner)
    var ownedHomes: [HomeModel]

    /// Array of `HomeModel` where this user is a member of.
    @Siblings(through: HomeMembersModel.self, from: \.$user, to: \.$home)
    var memberHomes: [HomeModel]

    init() {}

    init(name: String, lastname: String, email: String, phoneNumber: String, password: String) {
        self.name = name
        self.lastname = lastname
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
    }
}
