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
    
    static let HOST_URL: String =   envM.getHost()
    static let DOMAIN_URL: String = envM.getHost() + ""
    static let BASE_URL: String = HOST_URL + "api/"
    static let LOGIN: String = BASE_URL + "token/"
}
