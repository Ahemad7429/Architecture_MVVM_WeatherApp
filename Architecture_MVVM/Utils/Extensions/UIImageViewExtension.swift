//
//  UIImageViewExtension.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 23/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with urlString: String?, indicator: Bool = true, placeHolderImage: UIImage = UIImage(named: "img_sunrise")!) {
        if indicator {
            self.kf.indicatorType = .activity
        }
        if let imageUrl = urlString, !imageUrl.isEmpty {
            self.kf.setImage(with: URL(string: imageUrl))
        } else {
            self.image = placeHolderImage
        }
    }
    
}
