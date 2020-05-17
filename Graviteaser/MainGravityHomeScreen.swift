//
//  MainGravityHomeScreen.swift
//  Graviteaser
//
//  Created by omar on 2/22/19.
//  Copyright © 2019 Gravity. All rights reserved.
//

import UIKit
import CoreMotion

class MainGravityHomeScreen: UIViewController   {
    
    
    
    

    var viewsMeantToCollide = [UIImageView]()
    var gravityAnimator : UIDynamicAnimator!
    var gravityBehavior : UIGravityBehavior!
    var collision : UICollisionBehavior!
    var bouncingEffect : UIDynamicItemBehavior!
    var motionManager : CMMotionManager!
    var deviceCategory = ""
    var dockIconSize = CGSize(width: 80, height: 80)
    var dockIconsBottomMargin = 20.0
    var verticalSpacingBetweenIcons = CGFloat(35.0)
    var added = false
    
    var chosenWallpaper = ""
    var chosenMode = ""
    
    let mainIconsInScreen = [
        ["Messages" , "Calendar" , "Photos" ,"Camera"],
        ["Maps" , "Clock" , "Weather" , "Facetime"],
        ["Videos" , "Safari" , "Notes" , "Stocks"],
        ["iBooks" , "SDK","Mail" , "Compass"],
        ["Reminders" , "Health" , "AppStore" , "Podcats"],
        ["Notes" , "Music" , "Tips" , "Videos"]
        
    ]
    
    let mainDockIconsInScreen = ["Settings" , "Music" , "Compass" , "Mail"]
    
    let tagsForIconsInScreen = [
        [3001 , 3002 , 3003 ,3004],
        [3005 , 3006 , 3007 , 3008],
        [3009 , 3010 , 3011 , 3012],
        [3013 , 3014,3015 , 3016],
        [3017 , 3018 , 3019 , 3020],
        [3021 , 3022 , 3023 , 3024],
        [3025 , 3026 , 3027 , 3028],
        [1001,1002,1003,1004]
        
    ]
    var swipedDown = false
    
    
     @IBOutlet var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         viewsMeantToCollide = placeIconsInMainScreen()
        
        
        
        setupTapGuesture()
        setupSwipeGuesture()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if (UserDefaults.standard.string(forKey: "chosenWallpaper")) != nil {

            backgroundImage.image = UIImage(named: UserDefaults.standard.string(forKey: "chosenWallpaper")!)
            
        }
        else if (UserDefaults.standard.data(forKey: "chosenWallpaper")) != nil {
            let data =  (UserDefaults.standard.data(forKey: "chosenWallpaper")) as! NSData
            backgroundImage.image = UIImage(data: data as Data)
        }
        else {backgroundImage.image = UIImage(named: "wallpaper")}
        
        if ((UserDefaults.standard.string(forKey: "userSavedMode")) != nil) {
             chosenMode = UserDefaults.standard.string(forKey: "userSavedMode")!
        }
        else {chosenMode = "earth"}
       
        resetEveryThingToDefault()

    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            setupGravityAndCollisionEffects(iconsMeantToCollide: viewsMeantToCollide )
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        
        let location = touches.first?.location(in: view)
        
        if let hittest = view.hitTest(location!, with: nil) {
            
            if hittest is UIImageView {
                hittest.center = location!
                if chosenMode == "earth" {
                    setupGravityAndCollisionEffects(iconsMeantToCollide: viewsMeantToCollide)
                    
                }
               

            }
        }
    }
    
   
   
    fileprivate func setupSwipeGuesture() {
        let swipeDownGuesture = UISwipeGestureRecognizer(target: self, action: #selector(userSwipedDownWithTwoFingers(sender:)))
        swipeDownGuesture.direction = .down
        swipeDownGuesture.numberOfTouchesRequired = 2
        view.addGestureRecognizer(swipeDownGuesture)
    }
    
    
    fileprivate func setupTapGuesture() {
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(gravityIsGoingToWork(sender:)))
        view.addGestureRecognizer(tapGuesture)
    }
    
    @objc func userSwipedDownWithTwoFingers(sender : UISwipeGestureRecognizer) {
        resetEveryThingToDefault()
    }
    
    fileprivate func resetEveryThingToDefault() {
        if (gravityAnimator != nil) {
            gravityAnimator.removeAllBehaviors()
        }
        else {}
        
        
        
        view.subviews.forEach({
            if $0.tag != 2000 {
                $0.removeFromSuperview()
            }
        })
        
        
        
        UIView.animate(withDuration: 0.5) {
            self.viewsMeantToCollide = self.placeIconsInMainScreen()
        }
        
        added = false

    }
    
   
    
    
    // the tap guesture recognizer
    @objc func gravityIsGoingToWork(sender : UITapGestureRecognizer) {
        let pressedLocation = sender.location(in: self.view)
        if let hittest = view.hitTest(pressedLocation, with: nil) {
            if hittest is UIImageView {
                if hittest.tag == 1001 {
                    performSegue(withIdentifier: "goToSettingsWindow", sender: nil)
                    
                    
                }
            }
        }
        
        if (UserDefaults.standard.string(forKey: "userSavedMode")) != nil {
            chosenMode = UserDefaults.standard.string(forKey: "userSavedMode")!
        }
        else {chosenMode  = ""}
        
        switch chosenMode {
        case "earth":
            setupGravityAndCollisionEffects(iconsMeantToCollide: viewsMeantToCollide)
            view.viewWithTag(9898)?.removeFromSuperview()
            
            break
        case "moon":
            activateMoonEffect()
            break
            
        case "brokenScreen":
            
            if (added == false) {
                view.addSubview(setupBrokenScreenEffect())
                added = true
            }
            else {
                
                break
            }
            
            break
        default:
            break
        }
        
        
        
       
    }
    
    // the gravity and collision and bounce effects of the app
    fileprivate func setupGravityAndCollisionEffects(iconsMeantToCollide : [UIImageView] ) {
        gravityAnimator = UIDynamicAnimator(referenceView: view)
        gravityBehavior = UIGravityBehavior(items: viewsMeantToCollide )
        
        collision = UICollisionBehavior(items: viewsMeantToCollide)
        collision.translatesReferenceBoundsIntoBoundary = true
      
        bouncingEffect = UIDynamicItemBehavior(items: viewsMeantToCollide)
        bouncingEffect.elasticity = 0.3
    
        gravityBehavior = UIGravityBehavior(items: viewsMeantToCollide)
        gravityAnimator.addBehavior(gravityBehavior)
        gravityAnimator.addBehavior(collision)
        gravityAnimator.addBehavior(bouncingEffect)
    
       
        setupMotionManager()
       
    }
    
    // installin the motionManager to be able to grab the data of the accelerometer
    
    fileprivate func setupMotionManager() {
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.001
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
            self.gravityBehavior.gravityDirection = CGVector(dx: CGFloat((data?.acceleration.x)!), dy: CGFloat(-(data?.acceleration.y)!))
        }
        
    }
    
    
    // the functin that will help placing the icons on screen depending on the size of the screen for various devices
    
    fileprivate func placeIconsInMainScreen() -> [UIImageView] {
        
        
        var icons = [UIImageView]()
        
        var theNumberOfIconsInTheScreen = mainIconsInScreen.count
        
        switch view.frame.height {
        
            // this switch statement will help identifying the screen size of the device that is being used to open the app...
            
        case 1366:
            deviceCategory = "iPad"
            dockIconSize = CGSize(width: 100, height: 100)
            theNumberOfIconsInTheScreen = mainIconsInScreen.count - 1
            dockIconsBottomMargin = 30
            verticalSpacingBetweenIcons = 85
        case 896:
            theNumberOfIconsInTheScreen = mainIconsInScreen.count
            dockIconsBottomMargin = 15
            verticalSpacingBetweenIcons = 35
            
        case 812:
            theNumberOfIconsInTheScreen = mainIconsInScreen.count - 1
            verticalSpacingBetweenIcons = 35
        case 736:
            theNumberOfIconsInTheScreen = mainIconsInScreen.count - 1
            verticalSpacingBetweenIcons = 30
        case 667:
            theNumberOfIconsInTheScreen = mainIconsInScreen.count - 2
            verticalSpacingBetweenIcons = 25
        case 568:
            theNumberOfIconsInTheScreen = mainIconsInScreen.count - 2
            dockIconsBottomMargin = 10
            verticalSpacingBetweenIcons = 12
        default:
            break
        }
        
        for numberOfRows in 0..<theNumberOfIconsInTheScreen {
            for numberOfIcons in 0..<mainIconsInScreen[numberOfRows].count {
                
                let icon = UIImageView(image: UIImage(named: mainIconsInScreen[numberOfRows][numberOfIcons]))
                if deviceCategory == "iPad" {
                    icon.frame.size = CGSize(width: 100, height: 100)
                }
                else {
                    icon.frame.size = CGSize(width: 70, height: 70)
                }
                
                icon.contentMode = .scaleAspectFit
                icon.isUserInteractionEnabled = true
                var horizontalSpacesBetweenIcons = (view.frame.width - (4 * icon.frame.width)) / 5
                
                if deviceCategory == "iPad" {
                    horizontalSpacesBetweenIcons = (view.frame.width - (4 * icon.frame.width)) / 4
                    
                    if numberOfRows == 0 {
                        
                        icon.frame.origin = CGPoint(x: (CGFloat(Double(numberOfIcons) + 0.5) * horizontalSpacesBetweenIcons)  + CGFloat( icon.frame.width * CGFloat(numberOfIcons)), y: (CGFloat(numberOfRows + 1) * verticalSpacingBetweenIcons  ) +  CGFloat(numberOfRows ) * icon.frame.height)
                        
                        
                    }
                    else {
                        
                        icon.frame.origin = CGPoint(x: (CGFloat(Double(numberOfIcons) + 0.5) * horizontalSpacesBetweenIcons)  + CGFloat( icon.frame.width * CGFloat(numberOfIcons)), y: (CGFloat(numberOfRows + 1)  * verticalSpacingBetweenIcons  ) + 30 +  CGFloat(numberOfRows ) * icon.frame.height)
                        
                    }
                    
                }
                
                else {
                    if numberOfRows == 0 {
                        
                        icon.frame.origin = CGPoint(x: (CGFloat(numberOfIcons + 1) * horizontalSpacesBetweenIcons) + CGFloat( icon.frame.width * CGFloat(numberOfIcons)), y: (CGFloat(numberOfRows + 2) * verticalSpacingBetweenIcons  ) +  CGFloat(numberOfRows ) * icon.frame.height)
                    }
                    else {
                        
                        icon.frame.origin = CGPoint(x: (CGFloat(numberOfIcons + 1) * horizontalSpacesBetweenIcons) + CGFloat( icon.frame.width * CGFloat(numberOfIcons)), y: (CGFloat(numberOfRows + 2)  * verticalSpacingBetweenIcons  ) +  CGFloat(numberOfRows ) * icon.frame.height)
                        
                    }
                }
                
                
                

                icon.tag = tagsForIconsInScreen[numberOfRows][numberOfIcons]
                view.addSubview(icon)
                icons.append(icon)
                
            }
        }
        
        for numberOfDockIcon in 0..<mainDockIconsInScreen.count  {
            
            let dockIcon = UIImageView(image: UIImage(named: mainDockIconsInScreen[numberOfDockIcon]))
            if deviceCategory == "iPad" {
                dockIcon.frame.size = CGSize(width: 100, height: 100)
            }
            else {
                
                dockIcon.frame.size = CGSize(width: 70, height: 70)
            
            }
            dockIcon.contentMode = .scaleAspectFill
            dockIcon.isUserInteractionEnabled = true
            let horizontalSpacesBetweenIcons = (view.frame.width - (4 * dockIcon.frame.width)) / 5
            
            dockIcon.frame.origin = CGPoint(x: (CGFloat(numberOfDockIcon + 1) * horizontalSpacesBetweenIcons) + CGFloat( dockIcon.frame.width * CGFloat(numberOfDockIcon)), y: CGFloat(view.frame.height - CGFloat(dockIconsBottomMargin) - dockIcon.frame.height))
            
            dockIcon.tag = tagsForIconsInScreen.last![numberOfDockIcon]
            view.addSubview(dockIcon)
            icons.append(dockIcon)
            
            
        }
        
        
     
        return icons
    }
    
    
    fileprivate func activateMoonEffect() {
        UIView.animate(withDuration: 1.5) {
            self.viewsMeantToCollide.forEach({ (view) in
                view.frame.origin = CGPoint(x: Int(arc4random_uniform(UInt32(self.view.frame.width))), y: Int(arc4random_uniform(UInt32(self.view.frame.height))))
            })
        }
    }
    
    
    fileprivate func setupBrokenScreenEffect() -> UIImageView {
       
        let image : UIImageView = {
            
            let image = UIImageView(image: UIImage(named: "brokenGlass1"))
            
            image.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            
            image.tag = 9898
            
            return image
        }()
        
        return image
        
    }
    
    
    
    
}
