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
    let releaseDate: String?
    let coverURL: URL?
    
    init(movie: Movie) {
        self.title = movie.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: movie.releaseDate ?? "") {
            dateFormatter.dateFormat = "MMM/yyyy"
            self.releaseDate = dateFormatter.string(from: date)
        } else {
            self.releaseDate = ""
        }
        
        self.coverURL = URL(string: Constants.TMDbAPI.imagesEndpoint
            + (movie.posterPath ?? movie.backdropPath ?? ""))
    }
    
}
