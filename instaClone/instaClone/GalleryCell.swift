//
//  GalleryCell.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/29/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    var post: Post! {
        didSet {
            self.imageView.image = post.image
            self.dateLabel.text! += self.stringFromDate(date: post.date)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func stringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
}
