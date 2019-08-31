//
//  MoviesViewController.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 29/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let collectionViewPadding: CGFloat = 16.0
    
    var viewModel: MoviesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getMovies()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Setup
    
    private func setupCollectionView() {
        collectionView.prefetchDataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil),
                                forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
    }
    
    
    // MARK: - Helper
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.numberOfMovies()
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    
    // MARK: - API
    
    private func getMovies() {
        activityIndicatorView.startAnimating()
        viewModel.fetchMovies()
    }

}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier,
                                                      for: indexPath) as! MovieCollectionViewCell
        
        if !isLoadingCell(for: indexPath) {
            cell.viewModel = viewModel.viewModelForItemAt(indexPath: indexPath)
            cell.configure()
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showMovieDetailsAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionViewPadding,
                            left: collectionViewPadding,
                            bottom: collectionViewPadding,
                            right: collectionViewPadding)
    }
    
}

extension MoviesViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchMovies()
        }
    }
    
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.size.width - (collectionViewPadding *  3)
        let width = collectionViewWidth / 2
        let height = width * 1.85
        
        return CGSize(width: width, height: height)
    }
    
}


// MARK: - FetchMoviesDelegate

extension MoviesViewController: FetchMoviesDelegate {
    
    func fetchMoviesSuccess(newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            activityIndicatorView.stopAnimating()
            collectionView.isHidden = false
            collectionView.reloadData()
            return
        }
        
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        collectionView.reloadItems(at: indexPathsToReload)
    }
    
    func fetchMoviesFailure() {
        activityIndicatorView.stopAnimating()
    }
    
}
