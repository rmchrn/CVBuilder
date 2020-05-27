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
        let landingVC = LandingViewController()
        landingVC.coordinator = self
        navigationController.pushViewController(landingVC, animated: false)
    }
    
    func gotoCreateVC(_ isNewCV: Bool) {
        let createCVVC = CreateCVViewController()
        createCVVC.isNewCV = isNewCV
        createCVVC.coordinator = self
        navigationController.pushViewController(createCVVC, animated: false)
    }
    
    func gotoPersonalInfo(_ isNewCV: Bool) {
        let personalInfoVC = PersonalViewController()
        personalInfoVC.coordinator = self
        personalInfoVC.isNewCV = isNewCV
        navigationController.pushViewController(personalInfoVC, animated: false)
    }
    
    func gotoShowCVVC(personalInfo: PersonalInfo?) {
        let showCVVC = ShowCVViewController(withInfo: personalInfo)
//        showCVVC.coordinator = self
        navigationController.pushViewController(showCVVC, animated: false)
    }
}
