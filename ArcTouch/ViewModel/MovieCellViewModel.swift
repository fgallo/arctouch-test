//
//  MovieCellViewModel.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 30/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

struct MovieCellViewModel {
    
    let title: String
    let coverURL: URL?
    
    init(movie: Movie) {
        self.title = movie.title
        self.coverURL = URL(string: Constants.TMDbAPI.imagesEndpoint
            + (movie.posterPath ?? movie.backdropPath ?? ""))
    }
    
}
