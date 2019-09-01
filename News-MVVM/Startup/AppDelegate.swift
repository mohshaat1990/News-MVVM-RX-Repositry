//
//  AppDelegate.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 7/27/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit
import LocalizableLib
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func setupGlobalAppearance(){
        UITextField.appearance().substituteFontName = FontNames.Rpt.RptRegular
        UILabel.appearance().substituteFontName = FontNames.Rpt.RptRegular
        UILabel.appearance().substituteFontNameBold = FontNames.Rpt.RptBold
        UITextField.appearance().substituteFontNameBold = FontNames.Rpt.RptBold
    }
}

