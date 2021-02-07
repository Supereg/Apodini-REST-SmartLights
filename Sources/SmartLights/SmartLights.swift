//
// Created by Andreas Bauer on 05.02.21.
//

import Foundation
import Apodini
import ApodiniREST
import ApodiniDatabase
import FluentKit
import NIO


public struct SmartLightsWebService: WebService {
    public init() {}

    public var content: some Component {
        UserComponent()
        HomeComponent()
        DeviceComponent()
        AuthenticatedComponent()
    }

    public var configuration: Configuration {
        ExporterConfiguration()
            .exporter(RESTInterfaceExporter.self)

        // The sql lite will point to the include example file in the project root.
        // This configuration assumes execution is done in dev environment and
        // that the working directory is located inside "./build/{debug,release}/SmartLightsServer/"
        ApodiniDatabase.DatabaseConfiguration(.sqlite(.file("../../../example-database.sqlite")))
            .addMigrations(CreateMediaMigration())
            .addMigrations(CreateUserMigration())
            .addMigrations(CreateHomeMigration())
            .addMigrations(CreateHomeMemberMigration())
            .addMigrations(CreateDeviceMigration())
    }
}
