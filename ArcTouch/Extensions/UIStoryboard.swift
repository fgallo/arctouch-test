//
//  UIStoryboard.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 29/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    @nonobjc static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var moviesViewController: MoviesViewController {
        guard let viewController =
            UIStoryboard.main.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else {
                fatalError("MoviesViewController couldn't be found in Storyboard file")
        }
        return viewController
    }
    
    var movieDetailsViewController: MovieDetailsViewController {
        guard let viewController =
            UIStoryboard.main.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
                fatalError("MovieDetailsViewController couldn't be found in Storyboard file")
        }
        return viewController
    }
    
}
