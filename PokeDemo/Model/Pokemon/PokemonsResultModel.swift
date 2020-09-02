//
//  PokemonsResultModel.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

struct PokemonsResult: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [PokemonBrief]?
}
