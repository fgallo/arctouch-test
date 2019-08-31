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
    func fetchMoviesSuccess(newIndexPathsToReload: [IndexPath]?)
    func fetchMoviesFailure()
}

protocol MoviesNavigationDelegate: class {
    func movieSelected(_ movie: Movie)
}

class MoviesViewModel {
    
    private let provider: MoyaProvider<TMDbAPI>
    private var movies: [Movie]
    private var isFetchInProgress: Bool
    private var currentPage: Int
    var totalCount: Int
    
    weak var delegate: FetchMoviesDelegate?
    weak var navigationDelegate: MoviesNavigationDelegate?
    
    init(provider: MoyaProvider<TMDbAPI>) {
        self.provider = provider
        self.movies = []
        self.isFetchInProgress = false
        self.currentPage = 1
        self.totalCount = 0
    }
    
    func fetchMovies() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        provider.request(TMDbAPI.movies(page: currentPage)) { result in
            switch result {
            case .failure:
                self.isFetchInProgress = false
                self.delegate?.fetchMoviesFailure()
            case .success(let response):
                do {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    self.totalCount = movieResponse.totalMovies
                    self.movies.append(contentsOf: movieResponse.movies) 
                    DispatchQueue.main.async {
                        if movieResponse.page > 1 {
                            let indexPathsToReload = self.calculateIndexPathsToReload(from: movieResponse.movies)
                            self.delegate?.fetchMoviesSuccess(newIndexPathsToReload: indexPathsToReload)
                        } else {
                            self.delegate?.fetchMoviesSuccess(newIndexPathsToReload: nil)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.delegate?.fetchMoviesFailure()
                    }
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
        let startIndex = movies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
    func viewModelForItemAt(indexPath: IndexPath) -> MovieCellViewModel {
        let movie = movies[indexPath.row]
        return MovieCellViewModel(movie: movie)
    }
    
    func showMovieDetailsAt(indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        navigationDelegate?.movieSelected(movie)
    }
    
}
