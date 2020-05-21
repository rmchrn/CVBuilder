//
//  LandingViewController.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 20/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

class LandingViewController: AppBaseController {
    
    var createNewButton: UIButton!
    
    var fetchAndUpdateButton: UIButton!
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = LandingConstants.kVCTitle
        
        initialViewSetup()
    }
    
    fileprivate func initialViewSetup() {
        setupCreateNewButton()
        setupViewOrEditButton()
    }
    
    fileprivate func setupCreateNewButton() {
        createNewButton = UIButton()
        createNewButton.accessibilityIdentifier = "create new"
        createNewButton.backgroundColor = MainTheme().buttonPrimaryColor
        createNewButton.translatesAutoresizingMaskIntoConstraints = false
        createNewButton.setTitle(LandingConstants.kCreateNew, for: UIControl.State.normal)
        self.view.addSubview(createNewButton)
        createNewButton.setWidth(withContant: 150)
        createNewButton.setHeight(withContant: 40)
        createNewButton.addTarget(self, action: #selector(createNewResume), for: UIControl.Event.touchUpInside)
        self.createNewButton.center(in: self.view, offset: UIOffset(horizontal: 0, vertical: -25))
    }
    
    fileprivate func setupViewOrEditButton() {
        fetchAndUpdateButton = UIButton()
        fetchAndUpdateButton.accessibilityIdentifier = "view or edit"
        fetchAndUpdateButton.backgroundColor = MainTheme().buttonPrimaryColor
        fetchAndUpdateButton.translatesAutoresizingMaskIntoConstraints = false
        fetchAndUpdateButton.setTitle(LandingConstants.kViewOrEdit, for: UIControl.State.normal)
        self.view.addSubview(fetchAndUpdateButton)
        fetchAndUpdateButton.setWidth(withContant: 150)
        fetchAndUpdateButton.setHeight(withContant: 40)
        fetchAndUpdateButton.addTarget(self, action: #selector(viewOrEditResume), for: .touchUpInside)
        self.fetchAndUpdateButton.center(in: self.view, offset: UIOffset(horizontal: 0, vertical: +25))
    }
    
    @objc func createNewResume() {
        coordinator?.gotoCreateVC(true)
    }
    
    @objc func viewOrEditResume() {
        coordinator?.gotoCreateVC(false)
    }
    
}
