//
//  LookupResult.swift
//  CheckAppVersionKit
//
//  Created by Leo Ho on 2024/1/26.
//

import Foundation

public struct LookupResultResponse: Decodable {
    
    public let data: [LookupResultData]
    
    public let results: [AppInfo]
    
    public struct LookupResultData: Decodable {
        
        public let type: String
        
        public let attributes: Attributes
        
        public struct Attributes: Decodable {
            
            public let version: String
            
            public let expired: String
        }
    }
    
    public struct AppInfo: Decodable {
        
        public let version: String
        
        public let trackViewUrl: String
    }
}
