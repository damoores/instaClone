//
//  Post.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/28/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import UIKit
import CloudKit

struct Post {
    let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
}

enum PostError: Error {
    case writingImageToData
    case writingDataToDisk
}

extension Post {
    
    static func recordFor(post: Post) throws -> CKRecord? {
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else {
            throw PostError.writingImageToData
        }
        do {
            try data.write(to: post.image.path)
            let asset = CKAsset(fileURL: post.image.path)
            let record = CKRecord(recordType: "Post")
            record.setValue(asset, forKey: "image")
            return record
        } catch {
            throw PostError.writingDataToDisk
        }
    }
    
}
