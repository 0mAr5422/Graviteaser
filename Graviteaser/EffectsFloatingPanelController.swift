//
//  EffectsFloatingPanelController.swift
//  
//
//  Created by omar on 3/19/19.
//

import UIKit



class EffectsFloatingPanelController: UIViewController  {

    var chosenMode = ""
    
    let userDefaults = UserDefaults.standard
    let userDefaultsKeyForModes = "userSavedMode"
   
    @IBOutlet var earthMode: UISwitch!
    
    @IBOutlet var moonMode: UISwitch!
    
    @IBOutlet var thirdMode: UISwitch!
    
    
   
    
    @IBAction func earthMode(_ sender: UISwitch) {
        
        if sender.isOn {
            moonMode.setOn(false, animated: true)
            thirdMode.setOn(false, animated: true)
            chosenMode = "earth"
             userDefaults.set(chosenMode, forKey: userDefaultsKeyForModes)
        }
        
    }
    
    @IBAction func moonMode(_ sender: UISwitch) {
        if sender.isOn {
            earthMode.setOn(false, animated: true)
            thirdMode.setOn(false, animated: true)
            chosenMode = "moon"
             userDefaults.set(chosenMode, forKey: userDefaultsKeyForModes)
        }
    }
    
    @IBAction func thirdMode(_ sender: UISwitch) {
        
        if sender.isOn {
            earthMode.setOn(false, animated: true)
            moonMode.setOn(false, animated: true)
            chosenMode = "brokenScreen"
             userDefaults.set(chosenMode, forKey: userDefaultsKeyForModes)
        }
        
    }
    
        
        
   
    @IBAction func backButtonTapped(sender : UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
       
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Effects "
        
        if userDefaults.string(forKey: userDefaultsKeyForModes) != nil {
             chosenMode = userDefaults.string(forKey: userDefaultsKeyForModes)!
        }
        else {chosenMode = ""}
       
        
        switch chosenMode {
        case "earth":
            earthMode.setOn(true, animated: true)
            break
        case "moon":
            moonMode.setOn(true, animated: true)
            break
        case "brokenScreen":
            thirdMode.setOn(true, animated: true)
            break
        default:
            break
        }
        

    }
    
    
    
   
   
    

   
}
