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
        viewModel.loadPokemons {[weak self] (error) in
            guard let self = self else { return }
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        configureNavBar()
        tableView.register(UINib(nibName: "HomeRowCell", bundle: nil), forCellReuseIdentifier: "HomeRowCell")
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = viewModel.getItem(for: indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "HomeRowCell") as? HomeRowCell {
            cell.load(with: item)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
