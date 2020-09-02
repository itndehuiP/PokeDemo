//
//  PokemonBriefModel.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation
import NoDB

struct PokemonBrief: DBModel {
    var noDBIndex: Int?
    static var noDBIndexes: [String]? = ["url"]
    
    var name: String?
    var url: String?
}
