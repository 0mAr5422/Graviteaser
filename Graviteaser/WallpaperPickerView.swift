//
//  WallpaperPickerView.swift
//  Graviteaser
//
//  Created by omar on 3/29/19.
//  Copyright © 2019 Gravity. All rights reserved.
//

import UIKit


class WallpaperPickerView: UICollectionViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    var imagePicker = UIImagePickerController()
    var chosenWallpaper = ""
    let wallpapers = [
    ["wallpaper" , "wallpaper1" , "wallpaper2"]
    ]
    
   
    
    
    
    let userDefaults = UserDefaults.standard
    let userDefaultsKey = "chosenWallpaper"
    
    
    
    fileprivate func savePreferedUserData(chosenWallpaperr : String) {
        userDefaults.set(chosenWallpaperr , forKey: userDefaultsKey)
    }
    
    fileprivate func retrieveUserSavedData() -> String {
        chosenWallpaper = userDefaults.string(forKey: userDefaultsKey)!
        return chosenWallpaper
    }
    
    
    @IBAction func userClickedToAddWallpaper(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userDefaults.set(image.jpegData(compressionQuality: 0.75), forKey: userDefaultsKey)
            
        }
       
        dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
        
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        title = "Wallpapers"
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    override  func numberOfSections(in collectionView: UICollectionView) -> Int {
        return wallpapers.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpapers[section].count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let wallpaperCell = collectionView.dequeueReusableCell(withReuseIdentifier: "wallpaperCell", for: indexPath)
        
        wallpaperCell.frame.size = CGSize(width: collectionView.frame.width / 4, height: 220)
        
        let horizontalSpaceBetweenWallpapers =  (collectionView.frame.width - (3 * wallpaperCell.frame.width)) / 4
        
        let verticalSpaceBetweenWallpapers =
            (collectionView.frame.height - (3 * wallpaperCell.frame.height)) / 6
        
        wallpaperCell.frame.origin = CGPoint(x: CGFloat(indexPath.item + 1) * horizontalSpaceBetweenWallpapers + CGFloat(indexPath.item) * wallpaperCell.frame.width , y: CGFloat(indexPath.section + 1) * verticalSpaceBetweenWallpapers + CGFloat(indexPath.section) * wallpaperCell.frame.height )
        

        wallpaperCell.backgroundView = UIImageView(image: UIImage(named: wallpapers[indexPath.section][indexPath.item ]))
        wallpaperCell.backgroundView?.contentMode = .scaleAspectFill
        
        return wallpaperCell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
            savePreferedUserData(chosenWallpaperr: wallpapers[indexPath.section][indexPath.item])
            self.dismiss(animated: true, completion: nil)
        
      
    }
    
    
   
}
    
    
   

