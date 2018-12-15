//
//  SwipingController+extension.swift
//  AutoLayout
//
//  Created by 강준영 on 29/11/2018.
//  Copyright © 2018 강준영. All rights reserved.
//

import UIKit

extension SwipingController {
    
    //Notifies the container that the size of its view is about to change.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            // You can call this method at any time to update the layout information. This method invalidates the layout of the collection view itself and returns right away.
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControls.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControls.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally , animated: true)
            }
        } ) { (_) in
            
        }
    }
}
