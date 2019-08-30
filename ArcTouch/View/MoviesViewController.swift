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
        setupView()
        setupCollectionView()
        getMovies()
    }
    
    
    // MARK: - Setup
    
    private func setupView() {
        title = "Movies"
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil),
                                forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
    }
    
    
    // MARK: - API
    
    private func getMovies() {
        activityIndicatorView.startAnimating()
        viewModel.fetchMovies()
    }

}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier,
                                                      for: indexPath) as! MovieCollectionViewCell
        cell.viewModel = viewModel.viewModelForItemAt(indexPath: indexPath)
        cell.configure()
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

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.size.width - (collectionViewPadding *  3)
        let width = collectionViewWidth / 2
        let height = width * 1.8
        
        return CGSize(width: width, height: height)
    }
    
}

extension MoviesViewController: FetchMoviesDelegate {
    
    func fetchMoviesSuccess() {
        activityIndicatorView.stopAnimating()
        collectionView.reloadData()
    }
    
    func fetchMoviesFailure() {
        activityIndicatorView.stopAnimating()
    }
    
}
