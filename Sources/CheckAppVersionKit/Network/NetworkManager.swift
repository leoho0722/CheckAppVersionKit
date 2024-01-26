//
//  NetworkManager.swift
//  CheckAppVersionKit
//
//  Created by Leo Ho on 2024/1/26.
//

import Foundation
import SwiftHelpers

public class NetworkManager: NSObject {
    
    // MARK: NetworkManager Public Properties
    
    public static let shared = NetworkManager()
        
    // MARK: NetworkManager Private Properties
    
}

// MARK: NetworkManager Public Extensions

public extension NetworkManager {
    
    enum Error: Swift.Error {
        
        case notSupportQueryXcodeBuild
        
        case invalidURL
        
        case unknownStatus(Int)
        
        case jsonDecodeFailed
    }
    
    func checkVersion(appConfiguration: AppConfiguration) async throws -> LookupResultResponse {
        let result: LookupResultResponse = try await _checkVersion(appConfiguration: appConfiguration)
        return result
    }
}

// MARK: - NetworkManager Private Extensions

private extension NetworkManager {
    
    func _checkVersion<D>(appConfiguration: AppConfiguration) async throws -> D where D: Decodable {
        let request = try _buildURLRequest(appConfiguration)
        let (data, response) = try await URLSession.shared.data(for: request)
        let statusCode = (response as! HTTPURLResponse).statusCode
        guard let status = HTTP.HTTPStatus(rawValue: statusCode) else {
            throw NetworkManager.Error.unknownStatus(statusCode)
        }
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(D.self, from: data)
            return result
        } catch {
            debugPrint(error as! DecodingError)
            throw NetworkManager.Error.jsonDecodeFailed
        }
    }
    
    func _buildURLRequest(_ appConfiguration: AppConfiguration) throws -> URLRequest {
        var urlRequest: URLRequest
        
        switch AppEnvironment.runtime {
        case .xcode:
            throw NetworkManager.Error.notSupportQueryXcodeBuild
        case .testflight:
            guard let url = URL(string: "https://api.appstoreconnect.apple.com/v1/apps/\(appConfiguration.appStoreId)/builds") else {
                throw NetworkManager.Error.invalidURL
            }
            urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = [
                HTTP.HTTPHeaderFields.authentication.rawValue : "Bearer ***"
            ]
        case .appstore:
            guard let url = URL(string: "http://itunes.apple.com/tw/lookup?bundleId=\(appConfiguration.bundleId)") else {
                throw NetworkManager.Error.invalidURL
            }
            urlRequest = URLRequest(url: url)
        }
        
        return urlRequest
    }
}
