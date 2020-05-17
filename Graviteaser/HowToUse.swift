//
//  HowToUse.swift
//  Graviteaser
//
//  Created by omar on 3/30/19.
//  Copyright © 2019 Gravity. All rights reserved.
//

import UIKit

class HowToUse: UIViewController {

    
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var imageContainer: UIImageView!
    
    @IBOutlet var textFieldContainingInformationOnHowToUse: UITextView!
    
    
    var isInFirstTip = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "How to use"
        
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
        
        UIView.animate(withDuration: 1, animations: {
            self.imageContainer.frame.origin.y -= 40
        }) { (_) in
            UIView.animateKeyframes(withDuration: 1, delay: 0.25, options: [.autoreverse , .repeat], animations: {
                self.imageContainer.frame.origin.y += 40
            }, completion: nil)
        }
    }
    

    @IBAction func nextButton(_ sender: UIButton) {
        if isInFirstTip {
            UIView.animate(withDuration: 0.5, animations: {
                self.imageContainer.alpha = 0
            }) { (_) in
                UIView.animate(withDuration: 1) {
                    self.imageContainer.image = UIImage(named: "twoFingers")
                    self.imageContainer.alpha = 1
                }
            }
            
            UIView.animate(withDuration: 0.5) {
                self.textFieldContainingInformationOnHowToUse.text = "you can swipe down with two fingers to reset the icons to there original place"
            }
            
            isInFirstTip = false
             nextButton.setTitle("Got It", for: .normal)
        }
        else {
            navigationController?.popToRootViewController(animated: true)
        }
        
       
        
    }
    
}
