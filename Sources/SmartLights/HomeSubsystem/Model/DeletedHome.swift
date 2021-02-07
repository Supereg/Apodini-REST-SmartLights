//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import Apodini

struct DeletedHome: Content, Identifiable {
    let id: Home.ID
    var deleted = true
}
