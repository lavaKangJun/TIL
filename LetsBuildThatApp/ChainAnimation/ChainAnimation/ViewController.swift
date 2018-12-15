//
//  ViewController.swift
//  ChainAnimation
//
//  Created by 강준영 on 2018. 11. 15..
//  Copyright © 2018년 강준영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // setup UI
    
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    

    fileprivate func setupLabels() {
        titleLabel.numberOfLines = 0
        titleLabel.text = "Welecome To Company XZY"
        titleLabel.font = UIFont(name: "Futura", size: 34)
        bodyLabel.numberOfLines = 0
        bodyLabel.text = "Hello there! Thanks so much for downloading our brand new app and giving us a try. Make sure to leave us a goodreview in the AppStore \n\ncontact: \nwww.adc.com"
    }
    
    fileprivate func setupStackView() {
        let stackview = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        
        // stackview.axis default: horizontal
        stackview.axis = .vertical
        
        stackview.spacing = 8
        
        //subview에 먼저 추가되고 난 뒤에 constraint 조절해야함
        view.addSubview(stackview)
        
        //translatesAutoresizingMaskIntoConstraints: constraint 조절하기 위해서 사용
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackview.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        setupStackView()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation)))
    }

    @objc func handleTapAnimation() {
        print("Animating")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        })
        { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.titleLabel.alpha = 0
                //You use this function to create a new affine transform by adding translation values to an existing affine transform. The resulting structure represents a new affine transform, which you can use (and reuse, if you want) to move a coordinate system
               self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -200)
            })
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        })
        { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.bodyLabel.alpha = 0
                //You use this function to create a new affine transform by adding translation values to an existing affine transform. The resulting structure represents a new affine transform, which you can use (and reuse, if you want) to move a coordinate system
                self.bodyLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -200)
            })
        }
    }


}

