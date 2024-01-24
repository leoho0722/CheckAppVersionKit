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
    
    public static var runtime: Runtime {
        if _isXcode {
            return .xcode
        } else if _isTestFlight {
            return .testflight
        } else {
            return .appstore
        }
    }
    
    /// The current execution environment of the App
    public enum Runtime {
        
        /// Xcode Developement
        case xcode
        
        /// TestFlight Sandbox
        case testflight
        
        /// App Store
        case appstore
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

// MARK: - AppEnvironment Private Functions

private extension AppEnvironment {
    

}
