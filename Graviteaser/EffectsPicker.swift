//
//  EffectsPicker.swift
//  Graviteaser
//
//  Created by omar on 3/19/19.
//  Copyright © 2019 Gravity. All rights reserved.
//

import UIKit
import FloatingPanel

class EffectsPicker: UIViewController ,FloatingPanelControllerDelegate {

    var floatingPanelController : FloatingPanelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatingPanelController = FloatingPanelController()
        
        
        
        let floatingPanelContentController = storyboard?.instantiateViewController(withIdentifier: "contentcontroller") as? EffectsPicker
        floatingPanelController = FloatingPanelController()
        
        floatingPanelController.delegate = self
        
        
        floatingPanelController.show(floatingPanelContentController!, sender: nil)
        
        floatingPanelController.addPanel(toParent: self)
        floatingPanelController.surfaceView.cornerRadius = 24.0
        floatingPanelController.surfaceView.backgroundColor = .white
        floatingPanelController.move(to: .tip, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
