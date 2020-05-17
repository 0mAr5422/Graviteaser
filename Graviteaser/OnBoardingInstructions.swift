//
//  ViewController.swift
//  Graviteaser
//
//  Created by omar on 2/22/19.
//  Copyright © 2019 Gravity. All rights reserved.
//

import UIKit

class OnBoardingInstructions: UIViewController , UICollisionBehaviorDelegate  {
    
    // variables and constants
    
    var finishedFirstInstructions : Bool = false
    var gravityAnimator : UIDynamicAnimator!
    var gravityBehavior : UIGravityBehavior!
    
    var collisionBehavior : UICollisionBehavior!
    var bouncingBehavior : UIDynamicItemBehavior!
    
    
    
    /***************************************/

    // IBOutlets
    
    
    @IBOutlet var logoImage: UIImageView!
    
    @IBOutlet var gotItButton: UIButton!
    
    @IBOutlet var instructionsText: UITextView!
    
    @IBOutlet var welcomeLabel: UILabel!
    /***************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheGotItButton()
        instructionsText.font = UIFont.preferredFont(forTextStyle: .headline)
        instructionsText.adjustsFontForContentSizeCategory = true
        
        
    }
    
    fileprivate func setupTheGotItButton() {
        gotItButton.layer.cornerRadius = gotItButton.frame.height / 4
        gotItButton.layer.borderWidth = 2
        gotItButton.layer.borderColor = UIColor.init(displayP3Red: 0, green: 0, blue: 1, alpha: 0.6).cgColor
        
        
    }
    
    fileprivate func animateTextView() {
        
        
        instructionsText.alpha = 1
        UIView.animate(withDuration: 3) {
            self.instructionsText.alpha = 0
            
        }
        UIView.animate(withDuration: 1) {
            self.instructionsText.text = "You can tap the settings icon to get into the app settings"
            self.instructionsText.alpha = 1
        }
    }
    
    
    @IBAction func gotItButton(_ sender: UIButton) {
        
        if finishedFirstInstructions == false {
            animateTextView()
            sender.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
            sender.titleLabel?.adjustsFontForContentSizeCategory = true
            sender.titleLabel?.adjustsFontSizeToFitWidth = true
            sender.setTitle("Got It", for: .normal)
            finishedFirstInstructions = true
            
        }
        else if finishedFirstInstructions == true && sender.titleLabel?.text == "Got It"{
           setupOnBoardingAnimation()
            
            sender.setTitle("Open Graviteaser", for: .normal)
            
            
        }
        else if sender.titleLabel?.text == "Open Graviteaser" {
            UserDefaults.standard.set(true, forKey: "name")
            setupTransitionAnimation()
            
        }
        
        
    }
    
    fileprivate func setupTransitionAnimation() {
        UIView.animate(withDuration: 0.4, animations: {
            
            self.logoImage.frame.origin = CGPoint(x: 150, y: -500)
            self.logoImage.frame.size = CGSize(width: 100, height: 100)
            
        }, completion: { (true) in
            self.performSegue(withIdentifier: "GetToTheGravityHomeScreen", sender: nil)
        })
        
       
    }
    
    fileprivate func setupOnBoardingAnimation() {
        
        gravityAnimator = UIDynamicAnimator(referenceView: view)
       
        gravityBehavior = UIGravityBehavior(items: [logoImage])
        collisionBehavior = UICollisionBehavior(items: [logoImage  ])
        bouncingBehavior = UIDynamicItemBehavior(items: [logoImage ])
        
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        bouncingBehavior.elasticity = 0
        gravityBehavior.gravityDirection = CGVector(dx: 00, dy: 2)
        gravityAnimator.addBehavior(gravityBehavior)
        gravityAnimator.addBehavior(collisionBehavior)
        gravityAnimator.addBehavior(bouncingBehavior)
        collisionBehavior.collisionDelegate = self
        
        UIView.animate(withDuration: 1, animations: {
            self.instructionsText.alpha = 0
            self.welcomeLabel.alpha = 0
            self.gotItButton.isUserInteractionEnabled = false
        }) { (true) in
            UIView.animate(withDuration: 1) {
                self.welcomeLabel.alpha = 1
                self.welcomeLabel.text = "Enjoy The Gravity"
                self.gotItButton.isUserInteractionEnabled = true
            }
        }
        
       
    }
    
   
  
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
         let nn = item as! UIImageView
        
        UIView.animate(withDuration: 0.2) {
            
            nn.frame.size = CGSize(width: 1024, height: 1024)
            nn.contentMode = .scaleAspectFit
        }
       
        
    }
    
    
    
    

}

