//
//  EnvironmentManager.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

enum Environment {
    case production
    case testing
}

struct EnviromentManager {
    let environment: Environment = .testing
    
    func getHost() -> String {
        switch environment {
        case .testing:
            return "pokeapi.co"
        case .production:
            return "pokeapi.co"
        }
    }
    
    func getScheme() -> String {
        return "https"
    }
    
    func getBasePath() -> String {
        return "/api/v2"
    }
}
