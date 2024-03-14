//
//  UIStackView+Ext.swift
//  Bankey
//
//  Created by Baran Baran on 6.03.2024.
//

import UIKit

extension UIStackView{
    func addArrangedSubviews(_ views: UIView ...){
        for view in views {
            addArrangedSubview(view)
        }
    }
}
