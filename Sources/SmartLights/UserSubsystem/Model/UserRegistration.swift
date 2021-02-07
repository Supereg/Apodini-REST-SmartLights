//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini

struct UserRegistration: Codable, Content {
    let name: String
    let lastname: String
    let email: String
    let phoneNumber: String
    /// This is obviously not how you would do passwords.
    /// See https://auth0.com/blog/adding-salt-to-hashing-a-better-way-to-store-passwords/
    /// on how to properly hash and salt passwords in a real system.
    let password: String
}

extension UserModel {
    convenience init(from registration: UserRegistration) {
        self.init(
            name: registration.name,
            lastname: registration.lastname,
            email: registration.email,
            phoneNumber: registration.phoneNumber,
            password: registration.password
        )
    }
}
