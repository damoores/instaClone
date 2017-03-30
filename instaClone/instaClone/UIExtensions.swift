//
//  UIExtensions.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/28/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import UIKit

extension UIImage {
    func resizeTo(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    var path: URL {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Cannot access Document Directory")
        }
        return documentsDirectory.appendingPathComponent("image")
    }
    
}

extension UIResponder {
    static var identifier: String {
        return String(describing: self)
    }
    
}
