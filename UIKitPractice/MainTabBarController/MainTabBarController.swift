//
//  MainTabBarController.swift
//  UIKitPractice
//
//  Created by macbook on 11.02.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        let testVC = TestVc()
        testVC.tabBarItem.image = UIImage(systemName: "curlybraces.square")
        testVC.tabBarItem.title = "Adaptive"
        
        let equalSquaresVC = EqualSquaresViewController()
        equalSquaresVC.tabBarItem.image = UIImage(systemName: "star.square")
        equalSquaresVC.tabBarItem.title = "Squares"
        
        viewControllers = [
            testVC,
            equalSquaresVC
        ]
        
    }
}
