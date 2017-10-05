//
//  InstagramStoryViewController.swift
//  InstagramStoriesModule
//
//  Created by Farooque on 05/10/17.
//  Copyright © 2017 Quintype. All rights reserved.
//

import UIKit

class InstagramStoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var storyCollectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 1
        headerView.layer.masksToBounds = false
        headerView.layer.shadowOffset = CGSize.zero
        
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self

       
    }
    
    // pragme mark : - CollectionView Deleagtes
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstagramStoryCollectionViewCell", for: indexPath as IndexPath) as! InstagramStoryCollectionViewCell
        cell.backgroundColor = UIColor.white
        if (indexPath.row % 2 == 0)
        {
            let image: UIImage = UIImage(named: "Image-1")!
            cell.imageView.image = image
        }
        else
        {
            let image: UIImage = UIImage(named: "Image-2")!
            cell.imageView.image = image
        }
        
        cell.layer.cornerRadius = 50
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 1
              return cell
    }
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}

extension UIView{
    func addShadowView(view : UIView){
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize.zero
    }
}

