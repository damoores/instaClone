//
//  HomeViewController.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/27/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import UIKit
import AudioToolbox


class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.alpha = 0.0
        Filters.originalImage = self.imageView.image!
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0) { 
//            self.view.alpha = 1.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imageView.image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func presentPickSourceActionSheet() {
        let sourceActionSheetController = UIAlertController(title: "Source", message: "Please Select Source Type", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.presentImagePickerWith(sourceType: .camera)
                self.imageView.alpha = 1.0
            } else {
                self.presentNoCameraActionSheet()
            }
        }
        let photoAction = UIAlertAction(title: "Photo", style: .default) { (action) in
            self.presentImagePickerWith(sourceType: .photoLibrary)
            self.imageView.alpha = 1.0
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.imageView.alpha = 1.0
        }
        
        sourceActionSheetController.addAction(cameraAction)
        sourceActionSheetController.addAction(photoAction)
        sourceActionSheetController.addAction(cancelAction)
        
        self.present(sourceActionSheetController, animated: true, completion: nil)
    }
    
    func presentNoCameraActionSheet() {
        let noCameraActionSheetController = UIAlertController(title: "No Camera Found", message: "Why U No Haz Camera? Itz not 2002 anymorez...", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        noCameraActionSheetController.addAction(okAction)
        self.present(noCameraActionSheetController, animated: true) { (action) in
            self.imageView.alpha = 1.0
        }
    }
    
    func presentFilterActionSheet() {
        let filterActionSheetController = UIAlertController(title: "Filters", message: "Choose a filter to apply", preferredStyle: .actionSheet)
        let vintageAction = UIAlertAction(title: "Vintage", style: .default) { (action) in
            if let originalImage = self.imageView.image {
                Filters.originalImage = originalImage
                Filters.filter(name: .vintage, image: originalImage, completion: { (filteredImage) in
                    self.imageView.image = filteredImage
                })
            }
        }
        let blackAndWhiteAction = UIAlertAction(title: "B&W", style: .default) { (action) in
            if let originalImage = self.imageView.image {
                Filters.originalImage = originalImage
                Filters.filter(name: .blackAndWhite, image: originalImage, completion: { (filteredImage) in
                    self.imageView.image = filteredImage
                })
            }
        }
        let revertAction = UIAlertAction(title: "Revert Changes", style: .destructive) { (action) in
            self.imageView.image = Filters.originalImage
        }
        filterActionSheetController.addAction(vintageAction)
        filterActionSheetController.addAction(blackAndWhiteAction)
        filterActionSheetController.addAction(revertAction)
        self.present(filterActionSheetController, animated: true, completion: nil)
    }
    
    @IBAction func imageViewTapped(_ sender: Any) {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        UIView.animate(withDuration: 0.5) {
            self.imageView.alpha = 0.4
            
        }
        self.presentPickSourceActionSheet()
    }
    
    @IBAction func postButtonSelected(_ sender: Any) {
        if let image = self.imageView.image {
            let newPost = Post(image: image)
            CloudKitAPI.shared.save(post: newPost, completion: { (success) in
                print("Succes: \(success)")
            })
        }
    }
    
    @IBAction func filterButtonSelected(_ sender: Any) {
        self.presentFilterActionSheet()
    }

}
