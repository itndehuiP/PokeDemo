//
//  HomeRowCell.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation
import UIKit

class HomeRowCell: UITableViewCell {
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var leftImage: UIImageView!
    @IBOutlet private weak var separator: UIView!
    
    override func awakeFromNib() {
        configureView()
    }
    
    private func configureView() {
        title.font = UIFont.preferredFont(forTextStyle: .headline)
        leftImage.image = UIImage(asset: .pokeball)
        separator.layer.cornerRadius = 5
        separator.backgroundColor = UIColor.primary
    }
    
    func load(with pokemon: PokemonBrief) {
        title.text = pokemon.name
    }
}
