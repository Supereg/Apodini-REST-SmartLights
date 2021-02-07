//
// Created by Andreas Bauer on 04.02.21.
//

import SemVer

extension SemanticVersion: Encodable {
    public func encode(to encoder: Encoder) throws {
        try description.encode(to: encoder)
    }
}

extension SemanticVersion: Decodable {
    public init(from decoder: Decoder) throws {
        let versionString = try String(from: decoder)

        guard let version = SemanticVersion(versionString) else {
            throw DecodingError.typeMismatch(
                SemanticVersion.self,
                .init(codingPath: decoder.codingPath, debugDescription: "Illegal semver string representation: \(versionString)")
            )
        }

        self = version
    }
}
