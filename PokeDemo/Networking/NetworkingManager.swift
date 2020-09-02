//
//  NetworkingManager.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

class NetworkingManager {
    
    func load<T:Codable>(request: URLRequest, response: T.Type, completion: @escaping(SummarizeResponse) -> ()) {
        let session = NetworkingUtilities.createSession()
        session.dataTask(with: request) { data, response, error in
            
            var summarizeResponse = SummarizeResponse()
                
            if let response = response as? HTTPURLResponse {
                summarizeResponse.status = response.statusCode
            }
            if let data = data {
                do {
                    let dataResponse = try JSONDecoder().decode(T.self, from: data)
                    summarizeResponse.data =  dataResponse
                } catch {
                    summarizeResponse.error = error
                }
            }
            completion(summarizeResponse)
        }.resume()
    }
    
    func getRequest(for type: RequestType) -> URLRequest? {
        switch type {
        case .login(let model):
            return createRequest(method: .GET, headers: [.contentTypeJSON], body: model, url: NetworkingConstants.LOGIN)
        case .getPokemons:
            return nil
        }
    }
    
    private func createRequest<T: Codable>(method: RequestMethod, headers: [HTTPHeader], body: T? = nil, url: String, urlComponents: [String]? = nil) -> URLRequest? {
        guard let url = buildURL(address: url, urlComponents: urlComponents) else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = NetworkingUtilities.createHeaderDictionary(with: headers)
            if body != nil {
                request.httpBody = NetworkingUtilities.transformToData(model: body)
            }
            return request
    }
    
    private func buildURL(address: String, urlComponents: [String]?) -> URL? {
        guard var url = URL(string: address) else { return nil }
             if let urlComponents = urlComponents {
                 let path = NetworkingUtilities.createURLParameters(components: urlComponents)
                 url.appendPathComponent(path)
             }
        return url
    }
}
