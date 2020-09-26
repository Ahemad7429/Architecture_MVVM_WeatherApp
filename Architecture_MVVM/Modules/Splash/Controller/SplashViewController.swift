//
//  SplashViewController.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.openHomePage()
        }
    }

    private func openHomePage() {
        let homeViewController = HomeViewController.instantiateFrom(appStoryboard: .main)
        pushViewController(homeViewController)
    }
    
}
