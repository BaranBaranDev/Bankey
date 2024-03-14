//
//  UIStackView+Ext.swift
//  Bankey
//
//  Created by Baran Baran on 14.03.2024.
//

import UIKit


extension UIStackView{
    func addArrangedSubviews(_ views: UIView ...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
        }
    }
}
