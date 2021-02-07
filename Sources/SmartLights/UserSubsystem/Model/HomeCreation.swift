//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini

struct HomeCreation: Content, Codable {
    let name: String
    let street: String
    let zipCode: String
    let city: String
    let country: String
}

extension HomeModel {
    convenience init(from home: HomeCreation) {
        self.init(name: home.name, street: home.street, zipCode: home.zipCode, city: home.city, country: home.country)
    }
}
