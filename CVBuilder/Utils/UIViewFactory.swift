//
//  UIViewFactory.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 09/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

//This protocol create view dynamically and pass to view

protocol UIFactoryProtocol:UITextFieldDelegate {}

extension UIFactoryProtocol {
    func makeImageView(size:CGSize, target:UITapGestureRecognizer) -> UIImageView{
        let personalImageView = UIImageView()
        personalImageView.layer.borderWidth = 1.0
        personalImageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        personalImageView.translatesAutoresizingMaskIntoConstraints = false
        personalImageView.setHeight(withContant: size.height)
        personalImageView.setWidth(withContant: size.width)
        personalImageView.isUserInteractionEnabled = true
        personalImageView.addGestureRecognizer(target)
        
//        let tapLable = UILabel()
//        tapLable.text = "Click hear"
//        personalImageView.addSubview(tapLable)
//        tapLable.translatesAutoresizingMaskIntoConstraints = false
//        tapLable.centerXAnchor.constraint(equalTo: personalImageView.centerXAnchor).isActive = true
//        tapLable.centerYAnchor.constraint(equalTo: personalImageView.centerYAnchor).isActive = true
        
        return personalImageView
    }
   
    func makeTextField(size:CGSize, text:String, keyboadType:UIKeyboardType) -> UITextField {
        let customTextField = UITextField()
        customTextField.accessibilityIdentifier = text
        customTextField.placeholder = text
        customTextField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        customTextField.keyboardType = keyboadType
        customTextField.borderStyle = .roundedRect
        customTextField.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        customTextField.setHeight(withContant: size.height)
        customTextField.setWidth(withContant: size.width)
        return customTextField
    }
    
    func makeDatePicker(view:UIView) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: view.frame.size.height - 200, width: view.frame.size.width, height: 200)
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.maximumDate = Date()
        return datePicker
    }
    
    func makeToolBar(view:UIView) -> UIToolbar {
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: view.frame.size.height - 240, width: view.frame.size.width, height: 40)
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0, green: 50/256.0, blue: 220/256.0, alpha: 1.0)
        toolBar.sizeToFit()
        return toolBar
    }
}

