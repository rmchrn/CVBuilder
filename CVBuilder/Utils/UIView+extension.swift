//
//  UIView+extension.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 20/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

extension UIView {
    
    static func activate(constraints: [NSLayoutConstraint]) {
        constraints.forEach { ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate(constraints)
    }
    
    func pin(to view: UIView, insets: UIEdgeInsets = .zero) {
        UIView.activate(constraints: [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right)
        ])
    }
    
    func top(from view: UIView, constant: CGFloat =  0.0) {
        UIView.activate(constraints: [
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        ])
    }
    
    func trailing(from view: UIView, constant: CGFloat =  0.0) {
        UIView.activate(constraints: [
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
        ])
    }
    
    func leading(from view: UIView, constant: CGFloat =  0.0) {
        UIView.activate(constraints: [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        ])
    }
    
    func bottom(from view: UIView, constant: CGFloat =  0.0) {
        UIView.activate(constraints: [
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
        ])
    }
    
    func center(in view: UIView, offset: UIOffset = .zero) {
        UIView.activate(constraints: [
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.horizontal),
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.vertical)
        ])
    }
    
    func setWidth(withContant width: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(withContant height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
}
