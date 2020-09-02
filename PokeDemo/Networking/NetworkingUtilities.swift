//
//  NetworkingUtilities.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

class NetworkingUtilities {
    
    static func createSession(timeOut: Double = 30) -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = timeOut
        return URLSession(configuration: sessionConfiguration)
    }
    
    static func transformToData<T: Encodable>(model: T) -> Data? {
        let jsonEncoder = JSONEncoder()
        return try? jsonEncoder.encode(model)
    }
    
    static func createHeaderDictionary(with headers: [HTTPHeader]) -> [String:String]{
        var dict: [String : String] = [:]
        for header in headers {
            switch header {
            case .contentTypeJSON:
                dict[header.rawValue] = "application/json"
            case .authorization:
                if let token = KeychainWrapper.standard.string(forKey: SystemConstant.sessionToken.rawValue) {
                    dict[header.rawValue] = "Bearer " + token
                }
            }
        }
        return dict
    }
    
    static func buildURL(path: String, queryItems: [URLQueryItem]?) -> URL? {
        var components = URLComponents()
        components.scheme = NetworkingConstants.SCHEME
        components.host = NetworkingConstants.HOST
        components.path = "\(NetworkingConstants.BASEPATH)\(path)"
        components.queryItems = queryItems
        return components.url
    }
    
}
