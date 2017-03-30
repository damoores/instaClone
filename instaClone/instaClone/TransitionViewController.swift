//
//  TransitionViewController.swift
//  instaClone
//
//  Created by Jeremy Moore on 3/27/17.
//  Copyright © 2017 com.moore-and-daughters. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var demotivationalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        let _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            self.transition()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func labelTapped(_ sender: Any) { }
    
    func transition() {

        UIView.transition(with: self.imageView, duration: 1.0, options: .transitionFlipFromRight, animations: {
            self.demotivationalLabel.text = ""
            self.imageView.backgroundColor = UIColor.black
            self.imageView.image = nil
        }) { (completed) in
                        self.performSegue(withIdentifier: "HomeViewController", sender: self)
        }
    }
}
    

    

