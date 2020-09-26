//
//  UINavigationViewControllerExtension.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func popTo(viewController: UIViewController.Type, animated: Bool = true) {
        for controller in self.viewControllers as Array {
            if controller.isKind(of: viewController) {
                self.popToViewController(controller, animated: animated)
                break
            }
        }
    }
    
    open func pushViewControllers(_ inViewControllers: [UIViewController], animated: Bool) {
        var stack = self.viewControllers
        stack.append(contentsOf: inViewControllers)
        self.setViewControllers(stack, animated: animated)
    }
    
}

