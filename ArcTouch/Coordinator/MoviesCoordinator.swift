//
//  MoviesCoordinator.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 30/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit

class MoviesCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var moviesViewController: MoviesViewController?
    private var movieDetailsCoordinator: MovieDetailsCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let moviesViewController = UIStoryboard.main.moviesViewController
        moviesViewController.title = "Upcoming Movies"
        
        let moviesViewModel = MoviesViewModel(provider: TMDbProvider)
        moviesViewController.viewModel = moviesViewModel
        moviesViewModel.delegate = moviesViewController
        moviesViewModel.navigationDelegate = self
        presenter.pushViewController(moviesViewController, animated: true)
        
        self.moviesViewController = moviesViewController
    }
    
}

extension MoviesCoordinator: MoviesNavigationDelegate {
    
    func movieSelected(_ movie: Movie) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(presenter: presenter, movie: movie)
        movieDetailsCoordinator.start()

        self.movieDetailsCoordinator = movieDetailsCoordinator
    }
    
}
