//
// Created by Andreas Bauer on 06.02.21.
//

import Foundation
import FluentKit

final class MediaModel: Model {
    private(set) static var schema: String = Schema.media

    @ID(custom: .id, generatedBy: .database)
    var id: Int?

    @Field(key: "image_data")
    var imageData: Data

    init() {}

    init(id: Int? = nil, imageData: Data) {
        self.id = id
        self.imageData = imageData
    }

    func base64String() -> String {
        imageData.base64EncodedString()
    }
}
