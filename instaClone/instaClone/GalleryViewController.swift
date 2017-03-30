//
//  GalleryViewController.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/29/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var allPosts = [Post]() {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = GalleryCollectionViewLayout(columns: 2)
//        self.collectionView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updatePosts()
    }
    
    func updatePosts() {
        CloudKitAPI.shared.getPosts { (success, fetchedPosts) in
            if success {
                if let fetchedPosts = fetchedPosts {
                    self.allPosts = fetchedPosts
                }
            } else {
                print("error fetching posts")
            }
        }
    }

}

//MARK: UICollectionView DataSource and Delegate Extension
extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as! GalleryCell
        cell.post = self.allPosts[indexPath.row]
        return cell
    }

}
