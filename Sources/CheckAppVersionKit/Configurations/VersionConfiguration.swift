//
//  VersionConfiguration.swift
//  CheckAppVersionKit
//
//  Created by Leo Ho on 2024/1/26.
//

import Foundation

public struct VersionConfiguration {
    
    public let version: String
    
    public let build: String
    
    public init(version: String, build: String) {
        self.version = version
        self.build = build
    }
}
