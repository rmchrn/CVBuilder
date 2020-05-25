//
//  PersonalViewController.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 08/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

class PersonalViewController: AppBaseController {
    
    // MARK: - User interace variable/outlets
    @IBOutlet weak var personalInfoScrollView: UIScrollView!
    
    var firstName: UITextField?
    var lastName: UITextField?
    var phoneNumner: UITextField?
    var emailId: UITextField?
    var addressLine1: UITextField?
    var addressLine2: UITextField?
    var dateOfBirth: UITextField?
    var yearOfExperiece: UITextField?
    var skillSetWorked: UITextField?
    var primaryEducationMarks: UITextField?
    var secondaryEducationMarks: UITextField?
    var higherEducationMarks: UITextField?
    var datePicker = UIDatePicker()
    var toolBar = UIToolbar()
    var userImageView = UIImageView().self
    var personalModel = PersonalInfo()
    // MARK: - properties
    weak var coordinator: MainCoordinator?
    var viewModel = PersonalViewModel()
    var isNewCV: Bool = true
    
    // MARK: - View life cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up view intial view
        setUpInitialView()
        //Configure View from UIView Factory
        configureView()
        personalInfoScrollView.accessibilityIdentifier = "scrollView"
        
        loadData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Fill Personal Info model class from UI
    // swiftlint:disable:next cyclomatic_complexity
    fileprivate func createPeronalInfoModel() -> PersonalInfo {
        personalModel = PersonalInfo()
        if let firstName = firstName?.text {
            personalModel.firstName = firstName
        }
        if let lastName = lastName?.text {
            personalModel.lastName = lastName
        }
        if let phoneNumner = phoneNumner?.text {
            personalModel.phoneNumner = phoneNumner
        }
        if let emailId = emailId?.text {
            personalModel.emailId = emailId
        }
        if let addressLine1 = addressLine1?.text {
            personalModel.addressLine1 = addressLine1
        }
        if let addressLine2 = addressLine2?.text {
            personalModel.addressLine2 = addressLine2
        }
        if let dateOfBirth = dateOfBirth?.text {
            personalModel.dateOfBirth = dateOfBirth
        }
        personalModel.userImage = DataHolder.sharedInstance.getImage(imageName: PersonalViewConstants.kImageName)
        if let yearOfExperiece = yearOfExperiece?.text {
            personalModel.yearOfExperiece = yearOfExperiece
        }
        if let skillSetWorked = skillSetWorked?.text {
            personalModel.skillSetWorked = skillSetWorked
        }
        if let primaryEducationMarks = primaryEducationMarks?.text {
            personalModel.primaryEducationMarks = primaryEducationMarks
        }
        if let secondaryEducationMarks = secondaryEducationMarks?.text {
            personalModel.secondaryEducationMarks = secondaryEducationMarks
        }
        if let higherEducationMarks = higherEducationMarks?.text {
            personalModel.higherEducationMarks = higherEducationMarks
        }
        return personalModel
    }
    
    // MARK: - Set Up NavigationView
    fileprivate func setUpNavigationView() {
        let saveBarButtonItem = UIBarButtonItem.init(title: PersonalViewConstants.kSave, style: .done, target: self, action: #selector(saveSelector))
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
        self.title = PersonalViewConstants.kVCTitle
    }
    
    fileprivate func setUpInitialView() {
        //Set up Navigation view
        setUpNavigationView()
        //set up scroll view
        personalInfoScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        personalInfoScrollView.accessibilityIdentifier = "scrollView"
    }
    
    fileprivate func configureView() {
        setUpStackView()
    }
    
    // MARK: - Set Up Stack view
    fileprivate func setUpStackView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        guard let views = buildViews(target: tapGestureRecognizer) else { return }
        let stackView = UIStackView()
        for view in views {
            stackView.addArrangedSubview(view)
        }
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        personalInfoScrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.pin(to: self.personalInfoScrollView, insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    // MARK: - load View With Saved or FetchedData
    fileprivate func loadData() {
        if !isNewCV {
            viewModel.getProfileData { (personalInfo, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        self.showError(withMessage: error.localizedDescription)
                    } else {
                        self.loadViewWithSavedorFetchedData(info: personalInfo)
                    }
                }
            }
        }
    }
    
    func loadViewWithSavedorFetchedData(info: PersonalInfo?) {
        if let info = info {
            firstName?.text = info.firstName
            lastName?.text = info.lastName
            phoneNumner?.text = info.phoneNumner
            emailId?.text = info.emailId
            addressLine1?.text = info.addressLine1
            addressLine2?.text = info.addressLine2
            dateOfBirth?.text = info.dateOfBirth
            yearOfExperiece?.text = info.yearOfExperiece
            skillSetWorked?.text = info.skillSetWorked
            primaryEducationMarks?.text = info.primaryEducationMarks
            secondaryEducationMarks?.text = info.secondaryEducationMarks
            higherEducationMarks?.text = info.higherEducationMarks
            guard let url = URL(string: info.userImage) else {return}

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.userImageView.image = UIImage(data: imageData)
                    } else {
                        self.userImageView.image = UIImage(contentsOfFile: info.userImage)
                    }

                }
            }
        }
    }
    
    // MARK: - Save data locally.
    @objc func saveSelector() {
        self.showError(withMessage: "Working on it!!")
    }
    
    // MARK: - Dismiss Keyboard
    @objc func dismissKeyboard() {
        personalInfoScrollView.contentOffset = CGPoint(x: 0, y: 0)
        view.endEditing(true)
    }
    
    // MARK: - Show image picker
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        //        let tappedImage = tapGestureRecognizer.view as! UIImageView
        ImagePickerManager().pickImage(self) { image in
            //here is the image
            self.userImageView.image = image
            DataHolder.sharedInstance.saveImage(imageName: PersonalViewConstants.kImageName, image: image)
            
        }
    }
    // MARK: - Tool bar button methods
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        //self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        toolBar.isHidden = true
    }
    
     @objc func cancelClick() {
        datePicker.isHidden = true
        toolBar.isHidden = true
    }
    
    // MARK: - datePickerValueChanged methods
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = PersonalViewConstants.dateFormat
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        dateOfBirth?.text = selectedDate
    }
    
}
