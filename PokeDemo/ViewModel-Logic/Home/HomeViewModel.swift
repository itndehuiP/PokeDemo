//
//  HomeViewModel.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var pokemons: [PokemonBrief]?
    private let limit = 30
    private var offset = 0
    private var isFetchInProgress = false
    var totalCount: Int = 0
    
    weak var delegate: HomeFetchingDelegate?
    private let networkingManager = NetworkingManager()
    
    var currentCount: Int {
        return pokemons?.count ?? 0
    }

    func fetchPokemons(){
        guard !isFetchInProgress, let request = networkingManager.getRequest(for: .getPokemons(createQueryItems())) else {
            delegate?.onFetchFailed(with: "Request creation error")
            return
        }
        isFetchInProgress = true
        networkingManager.load(request: request, response: PokemonsResult.self) { (response) in
            DispatchQueue.main.async {
                if let data = response.data as? PokemonsResult {
                    self.totalCount = data.count ?? 0
                    self.append(result: data.results)
                    if self.currentCount > self.limit {
                        self.delegate?.onFetchCompleted(with: self.calculateIndexPathsToReload(from: data.results))
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                } else if let error = response.error {
                    self.delegate?.onFetchFailed(with: error.localizedDescription)
                }
            }
            self.isFetchInProgress = false
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
        offset = pokemons?.count ?? 0
    }
    
    private func createQueryItems() -> [URLQueryItem]? {
        let offset = pokemons?.count ?? 0
        return [URLQueryItem(name: "limit", value: "\(limit)"),
                    URLQueryItem(name: "offset", value: "\(offset)")]
    }
}
