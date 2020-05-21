//
//  ErrorPresentable.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 20/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

protocol ErrorPresentable {
    func showError(withMessage message:String)
}

extension ErrorPresentable where Self:UIViewController {
    func showError(withMessage message:String) {
        let alert = UIAlertController(title: Constants.kAlertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.kOk, style: UIAlertAction.Style.default) { (action) in
            alert.dismiss(animated: false, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: false, completion: nil)
    }
}
