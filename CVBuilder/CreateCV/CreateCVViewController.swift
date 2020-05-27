//
//  CreateCVViewController.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 20/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

class CreateCVViewController: AppBaseController {
    // MARK: - User interface variables
    var tableView: UITableView!

    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    
    var isNewCV: Bool = true
    
    var dataSource = [CreateCVConstants.kPersonalInfo]
    // MARK: - life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = CreateCVConstants.kVCTitle
        
        tableviewSetup()
    }
    // MARK: - UI setup helper methods
    fileprivate func tableviewSetup() {
         self.tableView = UITableView()
         self.tableView.translatesAutoresizingMaskIntoConstraints = false
         self.view.addSubview(tableView)
         self.tableView.pin(to: self.view)
         
         self.tableView.delegate = self
         self.tableView.dataSource = self
     }
    
}
// MARK: - Table view Datasource methods
extension CreateCVViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: CreateCVConstants.kReuseIdentifierForResumeTopic)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}
// MARK: - Table view Delegate methods
extension CreateCVViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            coordinator?.gotoPersonalInfo(isNewCV)
        case 1:
            self.showError(withMessage: "\(self.dataSource[indexPath.row]) is under development. Surely available in the next version")
        case 2:
            self.showError(withMessage: "\(self.dataSource[indexPath.row]) is under development. Surely available in the next version")
        case 3:
            self.showError(withMessage: "\(self.dataSource[indexPath.row]) is under development. Surely available in the next version")
        default:
            self.showError(withMessage: "\(self.dataSource[indexPath.row]) is under development. Surely available in the next version")
        }
    }
}

extension CreateCVViewController: ErrorPresentable {}
