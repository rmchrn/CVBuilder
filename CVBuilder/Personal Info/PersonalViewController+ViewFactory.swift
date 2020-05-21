//
//  PersonalViewController+ViewFactory.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 09/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

extension PersonalViewController: UIFactoryProtocol {
    // MARK: Build view from UIFactory
    func buildViews(target: UITapGestureRecognizer) -> [UIView]? {
        userImageView =  makeImageView(size: CGSize(width: 200, height: 200), target: target)
        let width = personalInfoScrollView.frame.width - 16
        firstName = makeTextField(size: CGSize(width: width, height: 40), text: PersonalViewConstants.kFirstNamePlaceholder, keyboadType: UIKeyboardType.default)
        firstName?.delegate = self
        lastName = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kLastNamePlaceholder, keyboadType: UIKeyboardType.default)
        lastName?.delegate = self
        phoneNumner = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kPhoneNumberPlaceholder, keyboadType: UIKeyboardType.phonePad)
        phoneNumner?.delegate = self
        emailId = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kEmailIdPlaceholder, keyboadType: UIKeyboardType.emailAddress)
        emailId?.delegate = self
        addressLine1 = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kAddressLine1, keyboadType: UIKeyboardType.default)
        addressLine1?.delegate = self
        addressLine2 = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kAddressLine2, keyboadType: UIKeyboardType.default)
        addressLine2?.delegate = self
        dateOfBirth = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kDobPlaceholder, keyboadType: UIKeyboardType.default)
        dateOfBirth?.delegate = self
        yearOfExperiece = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kExpPlaceholder, keyboadType: UIKeyboardType.numberPad)
        yearOfExperiece?.delegate = self
        skillSetWorked = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kSkillsetPlaceholder, keyboadType: UIKeyboardType.default)
        skillSetWorked?.delegate = self
        primaryEducationMarks = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kPrimaryEduMarksPlaceholder, keyboadType: UIKeyboardType.numberPad)
        primaryEducationMarks?.delegate = self
        secondaryEducationMarks = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kSecondaryEduMarksPlaceholder, keyboadType: UIKeyboardType.numberPad)
        secondaryEducationMarks?.delegate = self
        higherEducationMarks = makeTextField(size: CGSize(width: width, height: 50), text: PersonalViewConstants.kHigherEduMarksPlaceholder, keyboadType: UIKeyboardType.numberPad)
        higherEducationMarks?.delegate = self
        return [userImageView, firstName as Any, lastName as Any, phoneNumner as Any, emailId as Any, addressLine1 as Any, addressLine2 as Any, dateOfBirth as Any, yearOfExperiece as Any, skillSetWorked as Any, primaryEducationMarks as Any, secondaryEducationMarks as Any, higherEducationMarks as Any].compactMap({$0}) as? [UIView]
    }
    
    func showDatePicker() {
        // DatePicker
        datePicker = makeDatePicker(view: self.view)
        datePicker.accessibilityIdentifier = "DOB"
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        view.addSubview(datePicker)
        
        // ToolBar
        toolBar = makeToolBar(view: self.view)
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: PersonalViewConstants.kDone, style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: PersonalViewConstants.kCancel, style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        view.addSubview(toolBar)
        toolBar.isHidden = false
        datePicker.isHidden = false
        
    }
}

// MARK: TextField Delegate methods.
extension PersonalViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        personalInfoScrollView.contentOffset = CGPoint(x: 0, y: 0)
        let point = textField.frame.origin//CGPoint(x: 0, y: textField.frame.origin.y + 100)
        personalInfoScrollView.contentOffset = point
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailId {
            if emailId?.text?.isValidEmail() ?? false {
                return
            } else {
                textField.becomeFirstResponder()
                showError(withMessage: PersonalViewConstants.invalidEmail)
            }
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateOfBirth {
            dismissKeyboard()
            showDatePicker()
            return false
        }
        cancelClick()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumner || textField == primaryEducationMarks || textField == secondaryEducationMarks || textField == higherEducationMarks || textField == yearOfExperiece {
            var maxLength = 2 //To restrict only to enter 2 numberss
            if textField == phoneNumner {
                maxLength = 10 //To restrict only to enter 10 numberss
            }
            //To restrict only to enter 10 numberss
            guard let text  = textField.text else { return true }
            let currentString: NSString = text as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        personalInfoScrollView.contentOffset = CGPoint(x: 0, y: 0)
        textField.resignFirstResponder()
        return true
    }
}

extension PersonalViewController: ErrorPresentable {}
