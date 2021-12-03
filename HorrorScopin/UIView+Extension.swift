//
//  UIView+Extension.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-03.
//

import UIKit

extension UIView {
    var enableAutoLayout: Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func addSubviewWithAutoLayout(_ subview: UIView) {
        addSubview(subview.enableAutoLayout)
    }
    
    func addSubviewsWithAutoLayout(_ subviews: [UIView]) {
        subviews.forEach {
            addSubview($0.enableAutoLayout)
        }
    }
}
