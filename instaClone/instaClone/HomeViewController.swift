//
//  HomeViewController.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/27/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func imageViewTapped(_ sender: Any) {
        self.presentPickSourceActionSheet()
    }
    
    func presentPickSourceActionSheet() {
        let sourceActionSheetController = UIAlertController(title: "Source", message: "Please Select Source Type", preferredStyle: .actionSheet)
        let camerAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.presentImagePickerWith(sourceType: .camera)
            } else {
                self.presentNoCameraActionSheet()
            }
        }
        let photoAction = UIAlertAction(title: "Photo", style: .default) { (action) in
            self.presentImagePickerWith(sourceType: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        sourceActionSheetController.addAction(camerAction)
        sourceActionSheetController.addAction(photoAction)
        sourceActionSheetController.addAction(cancelAction)
        
        self.present(sourceActionSheetController, animated: true, completion: nil)
    }

    func presentNoCameraActionSheet() {
        let noCameraActionSheetController = UIAlertController(title: "No Camera Found", message: "Why U No Haz Camera? Itz not 2002 anymorez...", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        noCameraActionSheetController.addAction(okAction)
        self.present(noCameraActionSheetController, animated: true, completion: nil)
    }
}
