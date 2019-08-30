//
//  Movie.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 29/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation

struct MovieResponse {
    let movies: [Movie]
}

extension MovieResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie {
    let id: Int
    let genreIds: [Int]
    let title: String
    let releaseDate: String?
    let posterPath: String?
    let backdropPath: String?
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case genreIds = "genre_ids"
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
