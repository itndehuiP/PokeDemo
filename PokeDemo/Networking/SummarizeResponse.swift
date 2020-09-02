//
//  Response.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

struct SummarizeResponse {
    var status: Int?
    var data: Codable?
    var error: Error?
}
