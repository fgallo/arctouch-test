//
//  MovieCollectionViewCell.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 30/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    static let cellIdentifier = "MovieCell"
    
    var viewModel: MovieCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        movieImageView.layer.cornerRadius = 4.0
        movieImageView.clipsToBounds = true
        movieImageView.backgroundColor = .lightGray
    }
    
    func configure() {
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        
        if let url = viewModel.coverURL {
            movieImageView.kf.indicatorType = .activity
            movieImageView.kf.setImage(
                with: url,
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }   
    }

}
