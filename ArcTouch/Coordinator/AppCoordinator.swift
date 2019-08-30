//
//  AppCoordinator.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 30/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    let moviesCoordinator: MoviesCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        moviesCoordinator = MoviesCoordinator(presenter: rootViewController)
        setupAppearance()
    }
    
    func start() {
        window.rootViewController = rootViewController
        moviesCoordinator.start()
        window.makeKeyAndVisible()
    }
    
    private func setupAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.white
        navigationBarAppearance.barTintColor = .black
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearance.isTranslucent = false
    }
}
