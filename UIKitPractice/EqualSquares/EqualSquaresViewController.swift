//
//  ViewController.swift
//  UIKitPractice
//
//  Created by Alexander Korchak on 30.11.2023.
//

import UIKit

// MARK: - Constant
extension EqualSquaresViewController {
    struct Constant {
        let catOne = UIImage(named: "cat1")
        let catTwo = UIImage(named: "cat2")
        let catThree = UIImage(named: "cat3")
        let catFour = UIImage(named: "cat4")
        
        let smallSpace: CGFloat = 5
        let largeSpace: CGFloat = 10
        let standartSize: CGSize = CGSize(width: 400, height: 400)
    }
}

final class EqualSquaresViewController: UIViewController {
    // MARK: - Attributes
    
    @Autolayout private var squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private var heightAnchor: NSLayoutConstraint?
    private var widthAnchor: NSLayoutConstraint?
    
    private let constant = Constant()
    
    // MARK: - Action
    
    @objc private func tapOnSquare() {
        Animator.animateSquare(self, heightConstraint: heightAnchor, widthConstraint: widthAnchor)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
        setupUI()
    }
    
    // MARK: - Methods
    
    private func setupAction() {
        let action = UITapGestureRecognizer(target: self, action: #selector(tapOnSquare))
        squareView.addGestureRecognizer(action)
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        let squareWithCatOne = UIImageView(image: constant.catOne)
        let squareWithCatTwo = UIImageView(image: constant.catTwo)
        let squareWithCatThree = UIImageView(image: constant.catThree)
        let squareWithCatFour = UIImageView(image: constant.catFour)

        let stackOne = UIStackView(arrangedSubviews: [squareWithCatOne, squareWithCatTwo], axis: .horizontal, spacing: constant.largeSpace)
        stackOne.distribution = .fillEqually
        
        let stackTwo = UIStackView(arrangedSubviews: [squareWithCatThree, squareWithCatFour], axis: .horizontal, spacing: constant.largeSpace)
        stackTwo.distribution = .fillEqually
        
        let stack = UIStackView(arrangedSubviews: [stackOne, stackTwo], axis: .vertical, spacing: 5)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        
        squareView.addSubview(stack)
        view.addSubview(squareView)
        
        NSLayoutConstraint.activate([
            squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stack.topAnchor.constraint(equalTo: squareView.topAnchor, constant: constant.smallSpace),
            stack.leadingAnchor.constraint(equalTo: squareView.leadingAnchor, constant: constant.smallSpace),
            stack.trailingAnchor.constraint(equalTo: squareView.trailingAnchor, constant: -constant.smallSpace),
            stack.bottomAnchor.constraint(equalTo: squareView.bottomAnchor, constant: -constant.smallSpace)
        ])
        
        heightAnchor = squareView.heightAnchor.constraint(equalToConstant: constant.standartSize.height)
        heightAnchor?.isActive = true
        
        widthAnchor = squareView.widthAnchor.constraint(equalToConstant: constant.standartSize.width)
        widthAnchor?.isActive = true
    }
}
