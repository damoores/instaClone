//
//  Cloudkit.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/27/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import Foundation
import CloudKit

class CloudKit {
    
    static let shared = CloudKit()
    let container = CKContainer.default()
    var privateDatabase: CKDatabase {
        return self.container.privateCloudDatabase
    }
    
}
