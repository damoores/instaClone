//
//  Filters.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/28/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import UIKit

typealias FilterCompletion = (UIImage?) -> ()

enum FilterName: String {
    case vintage = "CIPhotoEffectTransfer"
    case blackAndWhite = "CIPhotoEffectMono"
}

struct Filters {
    static var originalImage = UIImage()
    
    static func filter(name: FilterName, image: UIImage, completion: @escaping FilterCompletion) {
        OperationQueue().addOperation {
            guard let filter = CIFilter(name: name.rawValue) else { fatalError("Failed to create CIFilter") }
            let coreImage = CIImage(image: image)
            
            filter.setValue(coreImage, forKey: kCIInputImageKey)
            
            //GPU Context
            
            let options = [kCIContextWorkingColorSpace: NSNull()]
            guard let eaglContext = EAGLContext(api: .openGLES2) else { fatalError("Failed to create EAGLContext") }
            let ciContext = CIContext(eaglContext: eaglContext, options: options)
            //Get final image using GPU
            guard let outputImage = filter.outputImage else { fatalError("Failed to get ouput image from Filter") }
            if let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) {
                let finalImage = UIImage(cgImage: cgImage)
                OperationQueue.main.addOperation {
                    completion(finalImage)
                }
            } else {
                OperationQueue.main.addOperation {
                    completion(nil)
                }
            }
        
            
        }
    }
}
