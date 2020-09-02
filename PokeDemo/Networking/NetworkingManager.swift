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
            if let error = error {
                summarizeResponse.error = error
            } else if let data = data {
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
            return createRequest(method: .GET, headers: [.contentTypeJSON], body: model, path: NetworkingConstants.LOGIN, urlQueryItems: nil)
        case .getPokemons(let items):
            return createRequest(method: .GET, headers: [.contentTypeJSON], body: nil as PokemonsResult?, path: NetworkingConstants.GETPOKEMONS, urlQueryItems: items)
        }
    }
    
    private func createRequest<T: Codable>(method: RequestMethod, headers: [HTTPHeader], body: T? = nil, path: String, urlQueryItems: [URLQueryItem]?) -> URLRequest? {
        guard let url = NetworkingUtilities.buildURL(path: path, queryItems: urlQueryItems) else { return nil }
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = NetworkingUtilities.createHeaderDictionary(with: headers)
            if body != nil {
                request.httpBody = NetworkingUtilities.transformToData(model: body)
            }
            return request
    }
    

}
