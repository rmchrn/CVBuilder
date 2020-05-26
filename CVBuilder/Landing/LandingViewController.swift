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
    
    var viewButton: UIButton!
    
    var editButton: UIButton!
    
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
        setupViewButton()
        setupEditButton()
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
    }
    
    fileprivate func setupViewButton() {
        viewButton = UIButton()
        viewButton.accessibilityIdentifier = "view"
        viewButton.backgroundColor = MainTheme().buttonPrimaryColor
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        viewButton.setTitle(LandingConstants.kView, for: UIControl.State.normal)
        self.view.addSubview(viewButton)
        viewButton.setWidth(withContant: 150)
        viewButton.setHeight(withContant: 40)
        viewButton.addTarget(self, action: #selector(viewOrEditResume), for: .touchUpInside)
        stack.addArrangedSubview(viewButton)
    }
    
    fileprivate func setupEditButton() {
        editButton = UIButton()
        editButton.accessibilityIdentifier = "edit"
        editButton.backgroundColor = MainTheme().buttonPrimaryColor
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setTitle(LandingConstants.kEdit, for: UIControl.State.normal)
        self.view.addSubview(editButton)
        editButton.setWidth(withContant: 150)
        editButton.setHeight(withContant: 40)
        editButton.addTarget(self, action: #selector(viewOrEditResume), for: .touchUpInside)
        stack.addArrangedSubview(editButton)
    }
    
    // MARK: - Navigations
    @objc func createNewResume() {
        coordinator?.gotoCreateVC(true)
    }
    
    @objc func viewOrEditResume() {
        coordinator?.gotoCreateVC(false)
    }
    
}
