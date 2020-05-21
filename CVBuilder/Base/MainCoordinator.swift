//
//  MainCoordinator.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 20/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = LandingViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func gotoCreateVC(_ isNewCV:Bool) {
        let vc = CreateCVViewController()
        vc.isNewCV = isNewCV
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func gotoPersonalInfo(_ isNewCV:Bool) {
        let vc = PersonalViewController()
        vc.coordinator = self
        vc.isNewCV = isNewCV
        navigationController.pushViewController(vc, animated: false)
    }
}
