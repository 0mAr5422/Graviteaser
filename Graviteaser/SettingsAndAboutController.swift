//
//  SettingsAndAboutController.swift
//  Graviteaser
//
//  Created by omar on 2/27/19.
//  Copyright © 2019 Gravity. All rights reserved.
//

import UIKit


class SettingsAndAboutController: UITableViewController , UINavigationControllerDelegate   {
    
    
   
    
   
    
    var screenSize = 0
    
    var chosenMode = "990"
    
    
    
    let tableOptionsInSettingsView = ["Restore" , "Unlock","Effects", "Wallpapers" , "How to use" , "About"]
    
    

    fileprivate func getScreenSize() {
       
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About GravityPrank"
        
        getScreenSize()
        
        
    }
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableOptionsInSettingsView.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = tableOptionsInSettingsView[indexPath.row]
        cell?.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        cell?.textLabel?.adjustsFontForContentSizeCategory = true
        cell?.detailTextLabel?.text = ""
        cell?.imageView?.image = UIImage(named: tableOptionsInSettingsView[indexPath.row])
        cell?.imageView?.contentMode = .scaleAspectFit
        cell?.imageView?.frame.size = CGSize(width: 15, height: 15)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        let textView = UITextView()
        
        textView.frame.size = CGSize(width: tableView.frame.width, height: 100)
        textView.frame.origin = CGPoint(x: (tableView.frame.width - textView.frame.width) / 2, y: 0)
        
        
        textView.text = "You are in Viewer Mode . Purchase or Restore to unlock the full app"
        textView.textAlignment = .center
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        textView.adjustsFontForContentSizeCategory = true
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        
        tableView.estimatedSectionFooterHeight = 50
        tableView.sectionFooterHeight = UITableView.automaticDimension
        
        
        
        view.addSubview(textView)
        
        return view
    }
    
    
    
    
   
    
    

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  indexPath.row == 2{
            performSegue(withIdentifier: "EffecttsPicker", sender: nil)
        }
        else if indexPath.row == 5 {
            performSegue(withIdentifier: "GoToAboutScreen", sender: nil)
        }
        
        else if indexPath.row == 3 {
            performSegue(withIdentifier: "chooseWallpaper", sender: nil)
        }
        
        else if indexPath.row == 4 {
            performSegue(withIdentifier: "howToUse", sender: nil)
        }
    }
    
}
