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
    let date: Date
    
    static var identifier: String {
        return String(describing: self)
    }
    
    init(image: UIImage, date: Date = Date()) {
        self.image = image
        self.date = date
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
            record.setValue(post.date, forKey: "date")
            return record
        } catch {
            throw PostError.writingDataToDisk
        }
    }
    
    init?(fromRecord: CKRecord) {
        guard let asset = fromRecord["image"] as? CKAsset else { return nil }
        let path = asset.fileURL.path
        guard let image = UIImage(contentsOfFile: path)  else { return nil }
        guard let date = fromRecord["date"] as? Date else { return nil }
        self.init(image: image, date: date)
    }

}
