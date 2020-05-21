//
//  SuccessPresentable.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 20/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

protocol SuccessPresentable {
    func showSuccess(withMessage message: String)
}

extension SuccessPresentable where Self: UIViewController {
    func showSuccess(withMessage message: String) {
        let alert = UIAlertController(title: Constants.kAlertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.kOk, style: UIAlertAction.Style.default) { (_) in
            alert.dismiss(animated: false, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: false, completion: nil)
    }
}

protocol AlertPresentable: ErrorPresentable, SuccessPresentable {
    
}
