//
//  HomeViewModel.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

class HomeViewModel {
    let networkingManager = NetworkingManager()
    var pokemons: [PokemonBrief]?
    
    func loadPokemons(completion: @escaping(Error?) -> ()){
        guard let request = networkingManager.getRequest(for: .getPokemons) else {
            completion(ResponseError.requestCreationError)
            return
        }
        networkingManager.load(request: request, response: PokemonsResult.self) { (response) in
            DispatchQueue.main.async {
                if let data = response.data as? PokemonsResult {
                    self.pokemons = data.results
                }
            }
            completion(nil)
        }
    }
    
    func getItem(for index: Int?) -> PokemonBrief? {
        guard let pokemons = pokemons, let index = index, pokemons.isInRange(with: index) else {
            return nil
        }
        return pokemons[index]
    }
    
    func logOut() {
        KeychainWrapper.standard.removeAllKeys()
    }
}
