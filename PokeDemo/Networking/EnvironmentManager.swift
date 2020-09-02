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
        switch self.environment {
        case .production:
            return "https://park-in.mx/back/"
        case .testing:
            return "http://garagecoders.rocks:4000/"
        }
    }
}
