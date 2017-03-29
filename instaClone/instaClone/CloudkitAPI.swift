//
//  Cloudkit.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/27/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import Foundation
import CloudKit

typealias PostCompletion = (Bool) -> ()

class CloudKitAPI {
    
    static let shared = CloudKitAPI()
    let container = CKContainer.default()
    var privateDatabase: CKDatabase {
        return self.container.privateCloudDatabase
    }
    var publicDatabase: CKDatabase {
        return self.container.publicCloudDatabase
    }
    
    func save(post: Post, completion: @escaping PostCompletion) {
        do {
            if let record = try Post.recordFor(post: post) {
                self.publicDatabase.save(record, completionHandler: { (record, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        completion(false)
                        return
                    }
                    if let record = record {
                        print(record)
                        completion(true)
                    } else {
                        completion(false)
                    }
                })
            }
        } catch  {
            print(error)
        }
    }
    
}
