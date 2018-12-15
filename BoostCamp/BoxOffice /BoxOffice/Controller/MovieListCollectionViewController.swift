//
//  MovieListCollectionViewController.swift
//  BoxOffice
//
//  Created by 강준영 on 06/12/2018.
//  Copyright © 2018 강준영. All rights reserved.
//

import UIKit

class MovieListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    //MARK:- Property
    private let collectionViewCellId = "MovieListCollectionCell"
    private let movieListURL = "http://connect-boxoffice.run.goorm.io/movies?order_type="
    private let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private var collectionViewRefreshControl = UIRefreshControl()
    var movieList: [MovieList] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    var orderNumber: MovieSorting = MovieSorting.sortingReservation
    
    //MARK:- init
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        collectionView.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Lifecycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        super.viewWillAppear(true)
        setupCollectionView()
        movieInfoRequest(urlString: movieListURL, value: orderNumber.rawValue) { [weak self](success, error, movieListResult: MovieListResult?) in
            guard let self = self else { return }
            
            if success {
                if let movieListResult = movieListResult {
                    self.movieList = movieListResult.movies
                } else {
                    DispatchQueue.main.async {
                        showAlert(viewcontroller: self, title: "문제발생", message: "데이터를 가져올 수 없습니다.")
                    }
                }
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    showAlert(viewcontroller: self, title: "문제발생", message: "데이터를 가져올 수 없습니다.")
                }
            }
        }
        
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = self.collectionViewRefreshControl
        } else{
            collectionView.addSubview(collectionViewRefreshControl)
        }
        
        activityIndicatorView.startAnimating()

        self.collectionViewRefreshControl.addTarget(self, action: #selector(refreshMovieData), for: .valueChanged)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    //MARKL:- Refresh
    @objc func refreshMovieData() {
        movieInfoRequest(urlString: movieListURL, value: orderNumber.rawValue) { [weak self](success, error, movieListResult: MovieListResult?) in
            guard let self = self else { return }
            if success {
                if let movieListResult = movieListResult {
                    self.movieList = movieListResult.movies
                } else {
                    DispatchQueue.main.async {
                        showAlert(viewcontroller: self, title: "문제발생", message: "데이터를 가져올 수 없습니다.")
                    }
                }
                DispatchQueue.main.async {
                    self.collectionViewRefreshControl.endRefreshing()
                }
            } else {
                DispatchQueue.main.async {
                    self.collectionViewRefreshControl.endRefreshing()
                    showAlert(viewcontroller: self, title: "문제발생", message: "데이터를 가져올 수 없습니다.")
                }
            }
        }
    }
    
    //MARK:- Setup CollectionView
    func setupCollectionView() {
        let nib:UINib = UINib(nibName: "MovieListCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionViewCellId)
    }
    
    //MARK:- CollectionView
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as? MovieListCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.movieList = self.movieList[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let halfWith = UIScreen.main.bounds.width / 2
        return CGSize(width: halfWith - 7, height: 305)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailTableView = MovieDetailTableViewController()
        let movieList = self.movieList[indexPath.row]
        movieDetailTableView.movieId = movieList.id
        movieDetailTableView.movietitle = movieList.title
        navigationController?.pushViewController(movieDetailTableView, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1)
    }
    
   

}
