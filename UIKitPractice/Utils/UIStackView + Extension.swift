//
//  UIStackView + Extension.swift
//  UIKitPractice
//
//  Created by macbook on 11.02.2024.
//

import UIKit

// MARK: - Extension

extension UIStackView {
    // MARK: - Init
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.spacing = spacing
    }
}
