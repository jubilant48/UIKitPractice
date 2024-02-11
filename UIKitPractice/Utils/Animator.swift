//
//  Animator.swift
//  UIKitPractice
//
//  Created by macbook on 11.02.2024.
//

import UIKit

extension Animator {
    struct Constant {
        static let duration = 0.3
        
        static let minConstant: CGFloat = 16
        static let maxConstnt: CGFloat = 60
        
        static let highValue: CGFloat = 400
        static let middleHighValue: CGFloat = 300
        static let middleLowValue: CGFloat = 200
        static let lowValue: CGFloat = 100
    }
}

// MARK: - Animator

final class Animator: NSObject {
    
    static func animateInTop(_ controller: SuperVipPromoViewController, willShowButton button: UIButton, constraint: NSLayoutConstraint?) {
         let animator = UIViewPropertyAnimator(duration: Animator.Constant.duration, curve: .linear) {
            constraint?.constant = Animator.Constant.minConstant
            
            controller.view.layoutIfNeeded()
        }
        
        animator.addCompletion { _ in
            button.isHidden = false
        }
        
        animator.startAnimation()
    }
    
    static func animateInBottom(_ controller: SuperVipPromoViewController, willHideButton button: UIButton, constraint: NSLayoutConstraint?) {
        let animator = UIViewPropertyAnimator(duration: Animator.Constant.duration, curve: .linear) {
            button.isHidden = true
            constraint?.constant = Animator.Constant.maxConstnt
            
            controller.view.layoutIfNeeded()
        }
        
        animator.startAnimation()
    }
    
    
    static func animateSquare(_ controller: UIViewController, heightConstraint: NSLayoutConstraint?, widthConstraint: NSLayoutConstraint?) {
        let animator1 = UIViewPropertyAnimator(duration: Animator.Constant.duration, curve: .linear) {
            guard let width = widthConstraint?.constant,
                  let height = heightConstraint?.constant else { return }
            
            if width == Animator.Constant.highValue && height == Animator.Constant.highValue {
                widthConstraint?.constant = Animator.Constant.middleHighValue
                heightConstraint?.constant = Animator.Constant.middleHighValue
            }
            
            if width == Animator.Constant.middleHighValue && height == Animator.Constant.middleHighValue {
                widthConstraint?.constant = Animator.Constant.middleLowValue
                heightConstraint?.constant = Animator.Constant.middleLowValue
            }
            
            if width == Animator.Constant.middleLowValue && height == Animator.Constant.middleLowValue {
                widthConstraint?.constant = Animator.Constant.lowValue
                heightConstraint?.constant = Animator.Constant.lowValue
            }
            
            if width == Animator.Constant.lowValue && height == Animator.Constant.lowValue {
                widthConstraint?.constant = Animator.Constant.highValue
                heightConstraint?.constant = Animator.Constant.highValue
            }
            
            controller.view.layoutIfNeeded()
        }

        animator1.startAnimation()
    }
}
