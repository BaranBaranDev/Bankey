//
//  UIView+Ext.swift
//  Bankey
//
//  Created by Baran Baran on 4.03.2024.
//


import UIKit


extension UIView{
    func addSubviews(_ views: UIView ...){
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
