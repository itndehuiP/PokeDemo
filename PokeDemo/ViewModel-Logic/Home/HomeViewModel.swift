//
//  HomeViewModel.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation
import NoDB

class HomeViewModel {
    
    var pokemons: [PokemonBrief]?
    private let limit = 30
    private var offset = 0
    private var isFetchInProgress = false
    var totalCount: Int = 0
    private var pokemonsNoDB = NoDB<PokemonBrief>(name: SystemConstant.pokemonNoDB.rawValue, idKey: "url")
    private var errorFiredDate: Date?
    
    
    weak var delegate: HomeFetchingDelegate?
    private let networkingManager = NetworkingManager()
    
    var currentCount: Int {
        return pokemons?.count ?? 0
    }

    func fetchPokemons(){
        if let items = fetchFromDataBase(), !items.isEmpty {
            self.append(result: items)
            callFetchCompletion(results: items)
        } else {
            fetchFromServer()
        }
    }
    
    private func fetchFromServer() {
        guard !isFetchInProgress else {
            return
        }
        guard let request = networkingManager.getRequest(for: .getPokemons(createQueryItems())) else {
            delegate?.onFetchFailed(with: "Error while downloading")
            return
        }
        isFetchInProgress = true
        networkingManager.load(request: request, response: PokemonsResult.self) { (response) in
            DispatchQueue.main.async {
                if let data = response.data as? PokemonsResult {
                    self.saveTotalCount(total: data.count)
                    self.append(result: data.results)
                    self.callFetchCompletion(results: data.results)
                } else if let error = response.error {
                    self.triggerFetchFailed(error: error)
                }
            }
            self.isFetchInProgress = false
        }
    }
    
    private func triggerFetchFailed(error: Error) {
        let secondsPassed = -(Date().secondsInterval(from: self.errorFiredDate) ?? -31)
        print("secondsPassed \(secondsPassed)")
        if secondsPassed > 30 {
            self.errorFiredDate = Date()
            self.delegate?.onFetchFailed(with: error.localizedDescription)
        }
    }
        
    private func callFetchCompletion(results: [PokemonBrief]?) {
        if currentCount > limit {
           delegate?.onFetchCompleted(with: calculateIndexPathsToReload(from: results))
        } else {
            delegate?.onFetchCompleted(with: .none)
        }
    }
    
    private func fetchFromDataBase() -> [PokemonBrief]? {
        guard var savedElements = pokemonsNoDB.findSync() else { return nil }
        self.totalCount = loadTotalCount() ?? savedElements.count
        let lastIndex = ( offset - 1 ) + limit
        if savedElements.isInRange(with: lastIndex) {
            sortByURL(items: &savedElements)
            let start = Swift.min(0, (lastIndex - offset))
            let end = Swift.max(start, lastIndex)
            return Array(savedElements[start..<end])
        } else {
            return nil
        }
    }
    
    func getItem(for index: Int?) -> PokemonBrief? {
        guard let pokemons = pokemons, let index = index, pokemons.isInRange(with: index) else {
            return nil
        }
        return pokemons[index]
    }
    
    func logOut() {
        pokemonsNoDB.deleteDB()
        KeychainWrapper.standard.removeAllKeys()
        UserDefaults.standard.removeObject(forKey: SystemConstant.totalPokemonsCount.rawValue)
    }
    
    private func calculateIndexPathsToReload(from newPokemons: [PokemonBrief]?) -> [IndexPath]? {
        guard let newPokemons = newPokemons else { return nil }
        let startIndex = (pokemons?.count ?? 0) - newPokemons.count
        let endIndex = startIndex + newPokemons.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    private func append(result: [PokemonBrief]?) {
        guard let items = result else { return }
        if pokemons == nil {
            pokemons = []
        }
        pokemons?.append(contentsOf: items)
        if (pokemons?.count ?? 0) < 200 {
            saveToDB(new: items)
        }
        offset = pokemons?.count ?? 0
    }
    
    private func saveToDB(new items: [PokemonBrief]?) {
        guard let items = items else { return }
        pokemonsNoDB.save(obj: items)
        pokemonsNoDB.saveDB()
    }
    
    private func createQueryItems() -> [URLQueryItem]? {
        let offset = pokemons?.count ?? 0
        return [URLQueryItem(name: "limit", value: "\(limit)"),
                    URLQueryItem(name: "offset", value: "\(offset)")]
    }
    
    private func loadTotalCount() -> Int? {
        UserDefaults.standard.integer(forKey: SystemConstant.totalPokemonsCount.rawValue)
    }
    
    private func saveTotalCount(total: Int?){
        self.totalCount = total ?? 0
        UserDefaults.standard.set(totalCount, forKey: SystemConstant.totalPokemonsCount.rawValue)
    }
    
    func sortByURL(items: inout [PokemonBrief]) {
        items.sort {
               guard let first = $0.url, let second = $1.url else { return false }
               guard let id = first.split(separator: "/").last, let secondId = second.split(separator: "/").last else {
                   return false
               }
               let intId = Int("\(id)")
               let secondIntId = Int("\(secondId)")
               
               return (intId ?? 0) < (secondIntId ?? 0)
           }
    }
}
