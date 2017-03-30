//
//  Cloudkit.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/27/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import UIKit
import CloudKit

typealias PostCompletion = (Bool) -> ()
typealias PostsCompletion = (_ success: Bool, _ posts: [Post]?) -> ()

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
    
    func getPosts(completion: @escaping PostsCompletion) {
        let queryPredicate = NSPredicate(value: true)
        let postQuery = CKQuery(recordType: Post.identifier, predicate: queryPredicate)
        self.publicDatabase.perform(postQuery, inZoneWith: nil) { (fetchedRecords, error) in
            if error != nil {
                OperationQueue.main.addOperation {
                    print(error?.localizedDescription ?? "No desc")
                    completion(false, nil)
                }
            }
            if let fetchedRecords = fetchedRecords {

                var posts = [Post]()
                posts = fetchedRecords.flatMap { Post(fromRecord: $0) }
//                for record in fetchedRecords {
//                    if let asset = record["image"] as? CKAsset {
//                        let path = asset.fileURL.path
//                        if let image = UIImage(contentsOfFile: path) {
//                            let newPost = Post(image: image)
//                            posts.append(newPost)
//                        }
//                    }
//                }
                OperationQueue.main.addOperation {
                    completion(true, posts)
                }
            }
        }
    }
    
}
