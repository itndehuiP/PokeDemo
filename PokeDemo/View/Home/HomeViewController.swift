//
//  HomeViewController.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView(){
        tableView.register(UINib(nibName: "HomeRowCell", bundle: nil), forCellReuseIdentifier: "HomeRowCell")
        tableView.prefetchDataSource = self
        viewModel.delegate = self
        viewModel.fetchPokemons()
        configureNavBar()
    }
    
    
    private func configureNavBar() {
        self.title = "Poke List"
        self.navigationController?.setNavigationBar(with: [.logout(#selector(logOut))])
    }

    @objc private func logOut(){
        viewModel.logOut()
        self.navigationController?.setRoot(vc: .login)
    }
    
}

//MARK: Table view data source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeRowCell") as? HomeRowCell {
            if isLoadingCell(for: indexPath) {
                cell.load(with: .none)
            } else {
                cell.load(with: viewModel.getItem(for: indexPath.row))
            }
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: Table view prefetch data source
extension HomeViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
          if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchPokemons()
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= (viewModel.pokemons?.count ?? 0)
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
}

//MARK: Home fetching delegate
extension HomeViewController: HomeFetchingDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {

        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableView.isHidden = false
            tableView.reloadData()
            return
        }

        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
      
      let title = "Warning"
      let action = UIAlertAction(title: "OK", style: .default)
      displayAlert(with: title , message: reason, actions: [action])
    }
}
