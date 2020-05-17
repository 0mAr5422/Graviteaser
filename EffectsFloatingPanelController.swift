//
//  EffectsFloatingPanelController.swift
//  
//
//  Created by omar on 3/19/19.
//

import UIKit

class EffectsFloatingPanelController: UIViewController {

    
    @IBOutlet var earthMode: UISwitch!
    
    @IBOutlet var moonMode: UISwitch!
    
    @IBOutlet var brokenScreenMode: UISwitch!
    
    let userDefaults = UserDefaults.standard
    
    var chosenMode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Effects"
        
        switch UserDefaults.standard.string(forKey: "userSavedMode") {
        case "earth":
            earthMode.setOn(true, animated: true)
            break
        case "moon" :
            moonMode.setOn(true, animated: true)
            break
        case "brokenScreen":
            brokenScreenMode.setOn(true, animated: true)
            break
        default:
            break
        }
        
    }
    
    
    @IBAction func earthMode(_ sender: UISwitch) {
        if earthMode.isOn {
            moonMode.setOn(false, animated: true)
            brokenScreenMode.setOn(false, animated: true)
            chosenMode = "earth"
            userDefaults.set( chosenMode, forKey: "userSavedMode")
        }
    }
    
    
    
    @IBAction func moonMode(_ sender: UISwitch) {
        if moonMode.isOn {
            earthMode.setOn(false, animated: true)
            brokenScreenMode.setOn(false, animated: true)
            chosenMode = "moon"
            userDefaults.set( chosenMode, forKey: "userSavedMode")
        }
    }
    
    
    
    @IBAction func brokenScreenMode(_ sender: UISwitch) {
        if brokenScreenMode.isOn {
            moonMode.setOn(false, animated: true)
            earthMode.setOn(false, animated: true)
            chosenMode = "brokenScreen"
            userDefaults.set( chosenMode, forKey: "userSavedMode")
        }
    }
    
    
    
    

   
}
