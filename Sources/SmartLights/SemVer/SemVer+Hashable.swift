//
// Created by Andreas Bauer on 05.02.21.
//

import SemVer

extension SemanticVersion: Hashable {
    public func hash(into hasher: inout Hasher) {
        description.hash(into: &hasher)
    }
}
