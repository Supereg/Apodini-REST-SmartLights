//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import Apodini
import NIO
import FluentKit

struct UserHomeListHandler: Handler {
    @Throws(.notFound, reason: "User not found")
    var userNotFound: ApodiniError
    @Throws(.badInput, reason: "Boolean flag `owner` was given in an illegal format")
    var illegalOwnerFlag: ApodiniError

    @Binding
    var userId: User.ID
    @Parameter
    var owner: String?
    // boolean flag (String workaround, as Bool is initialized with false as standard with Vapor)

    @Environment(\.database)
    var database: Database

    func handle() throws -> EventLoopFuture<[UserHome]> {
        var queryBuilder = UserModel
            .query(on: database)
            .filter(\._$id == userId)

        let ownerFlag = try optionalOwnerFlag()
        if ownerFlag == nil || ownerFlag == true {
            queryBuilder = queryBuilder.with(\.$ownedHomes)
        }
        if ownerFlag == nil || ownerFlag == false {
            queryBuilder = queryBuilder.with(\.$memberHomes)
        }

        return queryBuilder
            .first()
            .unwrap(orError: userNotFound)
            .map { userModel in
                var homes: [HomeModel] = []
                if userModel.$ownedHomes.value != nil {
                    homes.append(contentsOf: userModel.ownedHomes)
                }
                if userModel.$memberHomes.value != nil {
                    homes.append(contentsOf: userModel.memberHomes)
                }

                return homes.map { home in
                    UserHome(user: userId, from: home)
                }
            }
    }

    /// Vapor automatically turns a optional Boolean query parameter into `false`
    /// if the parameter didn't exist on the query. However, we need to distinguish
    /// between owner=false and no owner flag sent, thus the string workaround.
    private func optionalOwnerFlag() throws -> Bool? { // swiftlint:disable:this discouraged_optional_boolean
        guard let ownerString = owner else {
            return nil
        }

        guard let ownerFlag = Bool(ownerString) else {
            throw illegalOwnerFlag
        }

        return ownerFlag
    }
}
