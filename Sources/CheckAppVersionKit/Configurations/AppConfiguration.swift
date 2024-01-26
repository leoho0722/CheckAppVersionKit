//
//  AppConfiguration.swift
//  CheckAppVersionKit
//
//  Created by Leo Ho on 2024/1/24.
//

public struct AppConfiguration {
    
    public let bundleId: String
    
    public let appStoreId: String
    
    public let version: VersionConfiguration
    
    public init(bundleId: String, appStoreId: String, version: VersionConfiguration) {
        self.bundleId = bundleId
        self.appStoreId = appStoreId
        self.version = version
    }
}
