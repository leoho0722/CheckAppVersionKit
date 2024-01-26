//
//  Environment.swift
//  CheckAppVersionKit
//
//  Created by Leo Ho on 2024/1/24.
//

import Foundation

/// Define the environment of the App
public struct AppEnvironment {
    
    // MARK: AppEnvironment Public Properties
    
    public static var currentVersion: String {
        let versionName = try! _getInfoPlist()["CFBundleShortVersionString"]!
        let versionCode = try! _getInfoPlist()["CFBundleVersion"]!
        return versionName + " \(versionCode)"
    }
    
    public static var runtime: Runtime {
        if _isXcode {
            return .xcode
        } else if _isTestFlight {
            return .testflight
        } else {
            return .appstore
        }
    }
    
    // MARK: AppEnvironment Private Properties
    
    private static var _isXcode: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    private static var _isTestFlight: Bool {
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
           appStoreReceiptURL.lastPathComponent == "appStoreReceiptURL" {
            return true
        } else {
            return false
        }
    }
}

// MARK: - AppEnvironment Public Extensions

public extension AppEnvironment {
    
    /// The current execution environment of the App
    enum Runtime {
        
        /// Xcode Developement
        case xcode
        
        /// TestFlight Sandbox
        case testflight
        
        /// App Store
        case appstore
    }
    
    /// Define AppEnvironment Error
    enum Error: Swift.Error, LocalizedError, CustomStringConvertible {

        /// Can't found the Info.plist file in Bundle.main
        case notFoundInfoPlist
        
        internal static let errorPrefix: String = "[AppEnvironmentError] "
        
        public var description: String {
            switch self {
            case .notFoundInfoPlist:
                return AppEnvironment.Error.errorPrefix + "Can't found the Info.plist file in Main Bundle."
            }
        }
        
        public var errorDescription: String? {
            switch self {
            case .notFoundInfoPlist:
                return AppEnvironment.Error.errorPrefix + "Can't found the Info.plist file in Main Bundle."
            }
        }
    }
}

// MARK: - AppEnvironment Private Extensions

private extension AppEnvironment {
    
    static func _getInfoPlist() throws -> Dictionary<String, String> {
        guard let infoPlist = Bundle.main.infoDictionary as? Dictionary<String, String> else {
            throw AppEnvironment.Error.notFoundInfoPlist
        }
        return infoPlist
    }
}
