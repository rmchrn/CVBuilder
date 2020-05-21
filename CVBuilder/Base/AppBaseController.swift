//
//  AppBaseController.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 20/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

class AppBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetup()
    }
    
    func initialUISetup() {
        self.view.backgroundColor = .white
    }
    
}
