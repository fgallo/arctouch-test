//
//  MovieDetailsViewController.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 30/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var viewModel: MovieDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieFields()
    }
    
    private func setupMovieFields() {
        overviewTextView.text = viewModel.movieOverview()
        releaseDateLabel.text = viewModel.movieReleaseDate()
        
        if let url = viewModel.movieCoverURL() {
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
