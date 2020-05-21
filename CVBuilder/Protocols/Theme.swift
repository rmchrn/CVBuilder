//
//  Theme.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 21/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

protocol Theme {
    var backgroundColor: UIColor { get }
    var secondaryBackgroundColor: UIColor {get}
    var heading: UIColor {get}
    var subHeading: UIColor {get}
    var sepratorColor: UIColor { get }
    var tintColor: UIColor { get }
    var buttonPrimaryColor: UIColor { get }
}

struct MainTheme: Theme {
    var backgroundColor: UIColor = UIColor.white
    var secondaryBackgroundColor = UIColor.lightGray
    var heading: UIColor = UIColor.black
    var subHeading: UIColor = UIColor.darkGray
    var sepratorColor: UIColor = UIColor.lightGray
    var tintColor: UIColor = UIColor.blue
    var buttonPrimaryColor = UIColor(red: 0, green: 50/256.0, blue: 220/256.0, alpha: 1.0)
}
struct SecondaryTheme: Theme {
    var backgroundColor = UIColor.black
    var secondaryBackgroundColor = UIColor.green
    var heading = UIColor.white
    var subHeading = UIColor.white
    var sepratorColor: UIColor = UIColor.darkGray
    var tintColor: UIColor = UIColor.blue
    var buttonPrimaryColor = UIColor(red: 0, green: 50/256.0, blue: 220/256.0, alpha: 1.0)
}
