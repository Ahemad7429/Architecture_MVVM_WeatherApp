//
//  UIViewControllerExtension.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 23/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiateFrom(appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func pushViewController(_ controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func presentViewController(_ controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(errorMsg: String, title: String = "Error", buttonTitle: String = "Okay", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: completion)
        }))
        presentViewController(alert)
    }
    
}
