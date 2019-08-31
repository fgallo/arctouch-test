//
//  MovieDetailsCoordinator.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 30/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit

class MovieDetailsCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var movieDetailsViewController: MovieDetailsViewController?
    private let movie: Movie
    
    init(presenter: UINavigationController, movie: Movie) {
        self.movie = movie
        self.presenter = presenter
    }
    
    func start() {
        let movieDetailsViewController = UIStoryboard.main.movieDetailsViewController
        movieDetailsViewController.title = movie.title
        movieDetailsViewController.viewModel = MovieDetailsViewModel(movie: movie)
        
        presenter.pushViewController(movieDetailsViewController, animated: true)
        self.movieDetailsViewController = movieDetailsViewController
    }
    
}
