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
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        configureView()
        setToNone()
    }
    
    private func configureView() {
        title.font = UIFont.preferredFont(forTextStyle: .headline)
        leftImage.image = UIImage(asset: .pokeball)
        separator.layer.cornerRadius = 5
        separator.backgroundColor = UIColor.secondary
        indicatorView.tintColor = UIColor.secondary
        indicatorView.hidesWhenStopped = true

    }
    
    func load(with pokemon: PokemonBrief?) {
        if let pokemon = pokemon {
            title.text = pokemon.name?.capitalized
            leftImage.alpha = 1
            indicatorView.stopAnimating()
        } else {
            setToNone()
        }
    }
    
    private func setToNone() {
        indicatorView.startAnimating()
        leftImage.alpha = 0
        title.text = nil
    }
}
