//
//  Autolayout.swift
//  UIKitPractice
//
//  Created by Alexander Korchak on 30.11.2023.
//

import UIKit

@propertyWrapper
public struct Autolayout<T: UIView> {
    // MARK: - Attributes
    
    public var wrappedValue: T {
        didSet {
            translatesAutoresizingMaskIntoConstraints()
        }
    }
    
    // MARK: - Init

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        translatesAutoresizingMaskIntoConstraints()
    }
    
    // MARK: - Methods

    private func translatesAutoresizingMaskIntoConstraints() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
