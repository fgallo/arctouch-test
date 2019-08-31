//
//  MovieDetailsViewModel.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 30/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func movieOverview() -> String? {
        return movie.overview
    }
    
    func movieReleaseDate() -> String? {
        var releaseDate = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: movie.releaseDate ?? "") {
            dateFormatter.dateFormat = "MMM/yyyy"
            releaseDate = dateFormatter.string(from: date)
        }
        
        return releaseDate
    }
    
    func movieCoverURL() -> URL? {
        return URL(string: Constants.TMDbAPI.imagesEndpoint + (movie.backdropPath ?? ""))
    }
    
}
