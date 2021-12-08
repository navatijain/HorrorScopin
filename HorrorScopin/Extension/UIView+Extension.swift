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
    
    func anchor(to superView: UIView, with inset:UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        [
            leftAnchor.constraint(equalTo: superView.leftAnchor, constant: inset.left),
            rightAnchor.constraint(equalTo: superView.rightAnchor, constant: inset.right),
            topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: inset.top),
            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: inset.bottom)
        ]
    }
}
