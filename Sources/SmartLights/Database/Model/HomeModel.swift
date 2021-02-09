//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import FluentKit

final class HomeModel: Model {
    static let schema: String = Schema.home

    @ID(custom: .id, generatedBy: .database)
    var id: Int?

    @Field(key: "name")
    var name: String

    @Parent(key: "owner_id")
    var owner: UserModel

    @Field(key: "street")
    var street: String
    @Field(key: "zip_code")
    var zipCode: String
    @Field(key: "city")
    var city: String
    @Field(key: "country")
    var country: String

    @Siblings(through: HomeMembersModel.self, from: \.$home, to: \.$user)
    var members: [UserModel]

    @Children(for: \.$home)
    var devices: [DeviceModel]

    init() {}

    init(id: Int? = nil, name: String, street: String, zipCode: String, city: String, country: String) {
        self.id = id
        self.name = name
        self.street = street
        self.zipCode = zipCode
        self.city = city
        self.country = country
    }
}
