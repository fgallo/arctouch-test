//
//  MoviesViewModel.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 29/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation
import Moya

protocol FetchMoviesDelegate: class {
    func fetchMoviesSuccess()
    func fetchMoviesFailure()
}

class MoviesViewModel {
    
    let provider: MoyaProvider<TMDbAPI>
    var movies: [Movie]
    
    weak var delegate: FetchMoviesDelegate?
    
    init(provider: MoyaProvider<TMDbAPI>) {
        self.provider = provider
        self.movies = []
    }
    
    func fetchMovies() {
        provider.request(TMDbAPI.movies(page: 1)) { result in
            switch result {
            case .failure:
                self.delegate?.fetchMoviesFailure()
            case .success(let response):
                do {
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    self.movies = movieResponse.movies
                    self.delegate?.fetchMoviesSuccess()
                } catch {
                    self.delegate?.fetchMoviesFailure()
                }
            }
        }
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
}
