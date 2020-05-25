//
//  LandingViewController.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 20/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

class LandingViewController: AppBaseController {
    // MARK: - User interface variables
    var createNewButton: UIButton!
    
    var fetchAndUpdateButton: UIButton!
    
    var stack: UIStackView!
    
    // MARK: - Coordinator
    weak var coordinator: MainCoordinator?
    
    // MARK: - life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = LandingConstants.kVCTitle
        
        initialViewSetup()
    }
    
    // MARK: - UI setup helper methods
    fileprivate func initialViewSetup() {
        stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.center(in: view)
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
        stack.addArrangedSubview(createNewButton)
        //self.createNewButton.center(in: self.view, offset: UIOffset(horizontal: 0, vertical: -25))
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
        stack.addArrangedSubview(fetchAndUpdateButton)
        //self.fetchAndUpdateButton.center(in: self.view, offset: UIOffset(horizontal: 0, vertical: +25))
    }
    
    // MARK: - Navigations
    @objc func createNewResume() {
        coordinator?.gotoCreateVC(true)
    }
    
    @objc func viewOrEditResume() {
        coordinator?.gotoCreateVC(false)
    }
    
}
