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
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let moviesViewController = UIStoryboard.main.moviesViewController
        let moviesViewModel = MoviesViewModel(provider: TMDbProvider)
        moviesViewController.viewModel = moviesViewModel
        moviesViewModel.delegate = moviesViewController
        presenter.pushViewController(moviesViewController, animated: true)
        
        self.moviesViewController = moviesViewController
    }
    
}
