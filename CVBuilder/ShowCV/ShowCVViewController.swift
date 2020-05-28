//
//  ShowCVViewController.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 26/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit
// swiftlint:disable:next type_body_length
class ShowCVViewController: AppBaseController {
    // MARK: - User interface variables
    var mainScrollView: UIScrollView!
    var contentView: UIView!
    var profileAvatarImageView: UIImageView!
    var basicInfoVStackView: UIStackView!
    var mobileNumberLabel: UILabel!
    var emailLabel: UILabel!
    var linkedInProfile: UILabel!
    
    var personalInfoSection: UIStackView!
    var personalInfoHeader: UIView!
    var personalInfoBody: UIView!
    
    var rolesAndResponsibilitiesSection: UIStackView!
    var rolesAndResponsibilitiesHeader: UIView!
    var rolesAndResponsibilitiesBody: UIStackView!
    // MARK: - Properties
    var personalInfo: PersonalInfo?
    var viewModel = ShowCVViewModel()
    // MARK: - inits
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(withInfo info: PersonalInfo?) {
        self.personalInfo =  info
        super.init(nibName: nil, bundle: nil)
    }
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
    }
    
    override func viewDidLayoutSubviews() {
        let contentRect: CGRect = mainScrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        mainScrollView.contentSize = contentRect.size
        mainScrollView.createPDF(from: mainScrollView, withName: "Ramcharan_resume")
    }
    fileprivate func initialViewSetup() {
        setupScrollView()
        setupBasicInfoVStack()
        setupMobileNumberLabel()
        setupEmailLabel()
        setupLinkedProfileLabel()
        setupProfileAvatar()
        setupRolesStack()
        if let roles = personalInfo?.rolesAndResponsibilities, !roles.isEmpty {
            setupRolesHeader()
        }
        setupPersonalInfoStack()
        setupPersonalHeader()
        guard let personalInfo = personalInfo else { return }
        self.title = personalInfo.firstName
        let lastView = self.contentView.subviews.last
        lastView?.bottomAnchor.constraint(equalToSystemSpacingBelow: self.contentView.bottomAnchor, multiplier: 1.0).isActive = true
    }
    
    fileprivate func setupMobileNumberLabel() {
        mobileNumberLabel = UILabel()
        let attributedString = boldAttributedString(withText: ShowCVConstants.mobileTitle)
        guard let personalInfo = personalInfo else { return }
        let normalString = normalAttributedString(withText: personalInfo.phoneNumner)
        attributedString.append(normalString)
        mobileNumberLabel.attributedText = attributedString
        mobileNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        mobileNumberLabel.sizeToFit()
        basicInfoVStackView.addArrangedSubview(mobileNumberLabel)
    }
    
    fileprivate func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.sizeToFit()
        basicInfoVStackView.addArrangedSubview(emailLabel)
        emailLabel.text = ""
        updateEmail()
    }
    
    fileprivate func setupLinkedProfileLabel() {
        linkedInProfile = UILabel()
        guard let personalInfo = personalInfo else { return }
        let boldString = boldAttributedString(withText: personalInfo.linkedInProofile, underLineRequired: true)
        boldString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange.init(location: 0, length: boldString.length))
        linkedInProfile.attributedText = boldString
        linkedInProfile.translatesAutoresizingMaskIntoConstraints = false
        linkedInProfile.sizeToFit()
        basicInfoVStackView.addArrangedSubview(linkedInProfile)
        linkedInProfile.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLinkedProfile))
        linkedInProfile.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func setupScrollView() {
        self.mainScrollView = UIScrollView()
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainScrollView)
        mainScrollView.pin(to: view)
        mainScrollView.alwaysBounceVertical = true
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(contentView)
        contentView.setWidth(withContant: view.frame.size.width)
        contentView.pin(to: mainScrollView, insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    fileprivate func setupBasicInfoVStack() {
        basicInfoVStackView = UIStackView()
        basicInfoVStackView.axis = .vertical
        basicInfoVStackView.spacing = 8
        contentView.addSubview(basicInfoVStackView)
        basicInfoVStackView.translatesAutoresizingMaskIntoConstraints = false
        basicInfoVStackView.top(from: contentView, constant: 0)
        basicInfoVStackView.leading(from: contentView, constant: 8)
        basicInfoVStackView.trailing(from: contentView, constant: 88)
        basicInfoVStackView.sizeToFit()
    }
    
    fileprivate func setupProfileAvatar() {
        profileAvatarImageView = UIImageView()
        profileAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        profileAvatarImageView.setWidth(withContant: 60)
        profileAvatarImageView.setHeight(withContant: 90)
        profileAvatarImageView.contentMode = .scaleAspectFit
        contentView.addSubview(profileAvatarImageView)
        profileAvatarImageView.top(from: contentView, constant: 0)
        profileAvatarImageView.trailing(from: contentView, constant: 8)
        guard let urlString = personalInfo?.userImage else { return }
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let imageData = data {
                    self.profileAvatarImageView.image = UIImage(data: imageData)
                } else {
                    self.profileAvatarImageView.image = UIImage(contentsOfFile: urlString)
                }
            }
        }
    }
    
    fileprivate func setupPersonalInfoStack() {
        personalInfoSection = UIStackView()
        personalInfoSection.translatesAutoresizingMaskIntoConstraints = false
        personalInfoSection.axis = .vertical
        personalInfoSection.spacing = 16
        contentView.addSubview(personalInfoSection)
        NSLayoutConstraint(item: personalInfoSection as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rolesAndResponsibilitiesSection as Any, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        personalInfoSection.leading(from: contentView, constant: 8)
        personalInfoSection.trailing(from: contentView, constant: 8)
    }
    
    fileprivate func setupPersonalHeader() {
        personalInfoHeader = UIView()
        personalInfoHeader.translatesAutoresizingMaskIntoConstraints = false
        personalInfoSection.addArrangedSubview(personalInfoHeader)
        personalInfoHeader.setHeight(withContant: 30)
        personalInfoHeader.setWidth(withContant: view.bounds.width - 16)
        personalInfoHeader.leading(from: contentView, constant: 8)
        personalInfoHeader.trailing(from: contentView, constant: 8)
        personalInfoHeader.backgroundColor = .lightGray
        let sectionTitle = UILabel()
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        personalInfoHeader.addSubview(sectionTitle)
        sectionTitle.center(in: personalInfoHeader)
        sectionTitle.text = ShowCVConstants.personalInfoTitle
        sectionTitle.sizeToFit()
        guard let personalInfo = personalInfo else { return }
        addPersonalRow(withTitle: ShowCVConstants.addressTitle, description: "\(personalInfo.addressLine1)\n\(personalInfo.addressLine2)")
        addPersonalRow(withTitle: ShowCVConstants.dobTitle, description: "\(personalInfo.dateOfBirth)")
        addPersonalRow(withTitle: ShowCVConstants.skillsTitle, description: "\(personalInfo.skillSetWorked)")
        addPersonalRow(withTitle: ShowCVConstants.higherEduTitle, description: "\(personalInfo.higherEducationMarks)")
        addPersonalRow(withTitle: ShowCVConstants.secondaryEduTitle, description: "\(personalInfo.secondaryEducationMarks)")
        addPersonalRow(withTitle: ShowCVConstants.primaryEduTitle, description: "\(personalInfo.primaryEducationMarks)")
    }
    
    fileprivate func addPersonalRow(withTitle tittle: String, description desc: String) {
        let addressRow = UIStackView()
        addressRow.axis = .horizontal
        addressRow.alignment = .top
        personalInfoSection.addArrangedSubview(addressRow)
        
        let title = UILabel()
        addressRow.addArrangedSubview(title)
        title.text = tittle
        title.font = UIFont.boldSystemFont(ofSize: 12)
        title.sizeToFit()
        
        let description = UILabel()
        addressRow.addArrangedSubview(description)
        description.font = UIFont.systemFont(ofSize: 12)
        description.numberOfLines = 0
        description.text = desc
        description.sizeToFit()
    }
    
    fileprivate func setupRolesStack() {
        rolesAndResponsibilitiesSection = UIStackView()
        rolesAndResponsibilitiesSection.translatesAutoresizingMaskIntoConstraints = false
        rolesAndResponsibilitiesSection.axis = .vertical
        rolesAndResponsibilitiesSection.spacing = 16
        contentView.addSubview(rolesAndResponsibilitiesSection)
        NSLayoutConstraint(item: rolesAndResponsibilitiesSection as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: profileAvatarImageView as Any, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        rolesAndResponsibilitiesSection.leading(from: contentView, constant: 8)
        rolesAndResponsibilitiesSection.trailing(from: contentView, constant: 8)
    }
    
    fileprivate func setupRolesHeader() {
        rolesAndResponsibilitiesHeader = UIView()
        rolesAndResponsibilitiesHeader.translatesAutoresizingMaskIntoConstraints = false
        rolesAndResponsibilitiesSection.addArrangedSubview(rolesAndResponsibilitiesHeader)
        rolesAndResponsibilitiesHeader.setHeight(withContant: 30)
        rolesAndResponsibilitiesHeader.setWidth(withContant: view.bounds.width - 16)
        rolesAndResponsibilitiesHeader.leading(from: contentView, constant: 8)
        rolesAndResponsibilitiesHeader.trailing(from: contentView, constant: 8)
        rolesAndResponsibilitiesHeader.backgroundColor = .lightGray
        let sectionTitle = UILabel()
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        rolesAndResponsibilitiesHeader.addSubview(sectionTitle)
        sectionTitle.center(in: rolesAndResponsibilitiesHeader)
        sectionTitle.text = ShowCVConstants.rolesAndResponsibilityTitle
        sectionTitle.sizeToFit()
        guard let personalInfo = personalInfo else { return }
        for role in personalInfo.rolesAndResponsibilities {
            let row = UIView()
            let bullet = UILabel()
            let point = UILabel()
            row.addSubview(bullet)
            row.addSubview(point)
            point.font = UIFont.systemFont(ofSize: 12.0)
            point.numberOfLines = 0
            row.translatesAutoresizingMaskIntoConstraints = false
            bullet.translatesAutoresizingMaskIntoConstraints = false
            point.translatesAutoresizingMaskIntoConstraints = false
            bullet.text =  "•"
            point.text = role
            bullet.sizeToFit()
            point.sizeToFit()
            point.pin(to: row, insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
            bullet.pin(to: row, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            rolesAndResponsibilitiesSection.addArrangedSubview(row)
        }
    }
    
    fileprivate func updateEmail() {
        let attributedString = boldAttributedString(withText: ShowCVConstants.emailTitle)
        guard let personalInfo = personalInfo else { return }
        let normalString = normalAttributedString(withText: personalInfo.emailId)
        attributedString.append(normalString)
        emailLabel.attributedText = attributedString
    }
    
    fileprivate func boldAttributedString(withText text: String, underLineRequired required: Bool = false) -> NSMutableAttributedString {
        let title = text
        var boldAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)] as [NSAttributedString.Key: Any]
        if required {
            boldAttributes[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        return NSMutableAttributedString(string: title, attributes: boldAttributes)
    }
    
    fileprivate func normalAttributedString(withText text: String) -> NSMutableAttributedString {
        let normalTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        return NSMutableAttributedString(string: text, attributes: normalTextAttributes)
    }
    
    @objc func openLinkedProfile() {
        guard let personalInfo = personalInfo else { return }
        guard let url = URL(string: personalInfo.linkedInProofile) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
extension ShowCVViewController: ErrorPresentable {}
extension UIScrollView: PDFConverible {}
