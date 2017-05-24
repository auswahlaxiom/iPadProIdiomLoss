//
//  UIApplicationExtension.swift
//  iPadProTraitCollectionIdiomLoss
//
//  Created by Ada Turner on 5/23/17.
//  Copyright © 2017 Auswahlaxiom. All rights reserved.
//

import UIKit

extension UIApplication {

    static func isLandscape(for size: CGSize) -> Bool {
        if (size.width > size.height) {
            return true
        } else {
            return false
        }
    }
}

