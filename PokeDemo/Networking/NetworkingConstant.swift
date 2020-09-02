//
//  NetworkingConstant.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

class NetworkingConstants: NSObject {
    static let envM = EnviromentManager()
    
    static let SCHEME: String = envM.getScheme()
    static let HOST: String = envM.getHost()
    static let BASEPATH: String = envM.getBasePath()
    
    static let LOGIN: String = "token/"
    static let GETPOKEMONS: String = "/pokemon"
}
