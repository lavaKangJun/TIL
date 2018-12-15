//
//  SwipingController.swift
//  AutoLayout
//
//  Created by 강준영 on 2018. 11. 19..
//  Copyright © 2018년 강준영. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainPinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "bear_first", headerText: "Join us today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon"),
        Page(imageName: "heart_second", headerText: "Subscribe and get cupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(imageName: "leaf_third", headerText: "Vip members special service", bodyText: "Join the private club of elite custom will get you into select drawings and giveaways. "),
        Page(imageName: "leaf_third", headerText: "Pick from your favorite toys", bodyText: "What are you waiting for? Join us today!")
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePrev() {
        let prevIndex = max(pageControls.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControls.currentPage = prevIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    lazy var pageControls: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPinkColor
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.mainPinkColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc func handleNext() {
        let nextIndex = min(pageControls.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControls.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonControls()
        
        collectionView?.backgroundColor  = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        //default NO. if YES, stop on multiples of view bounds
        collectionView?.isPagingEnabled = true
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x  = targetContentOffset.pointee.x
        pageControls.currentPage = Int(x / view.frame.width)
        print(x, view.frame.width, x / view.frame.width)
    }
    
    fileprivate func setupButtonControls(){
        
        let buttonControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControls , nextButton])
        buttonControlsStackView.distribution = .fillEqually
        buttonControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonControlsStackView)
        
        NSLayoutConstraint.activate([
            //safeAreaLayout
            buttonControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
}
