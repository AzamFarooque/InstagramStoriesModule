//
//  InstagramStoryViewController.swift
//  InstagramStoriesModule
//
//  Created by Farooque on 05/10/17.
//  Copyright © 2017 Quintype. All rights reserved.
//

import UIKit


class InstagramStoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var storyCollectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
     var navController : UINavigationController!
     let images = ["Image","Image-1","Image-2","Image-3","Image-4","Image-5","Image-6","Image-7","Image-8"]
     let name = ["Dhoni","Hrithik" ,"Salman" , "Dhawan" ,"Virat" , "Farooque" , "Steve" , "BilGate", "Arnab"]

    @IBOutlet weak var storiesTableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 1
        headerView.layer.masksToBounds = false
        headerView.layer.shadowOffset = CGSize.zero
        
        
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
        
        storiesTableView.delegate = self
        storiesTableView.dataSource = self

        
    
    }
    
     
   // pragme mark : - CollectionView Deleagtes
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstagramStoryCollectionViewCell", for: indexPath as IndexPath) as! InstagramStoryCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
         cell.imageView.image = UIImage(named : images[indexPath.row])
         cell.nameLabel.text = name[indexPath.row]
        
         cell.imageView.layer.cornerRadius = 45
         cell.imageView.clipsToBounds = true
         cell.imageView.layer.borderColor = UIColor.red.cgColor
         cell.imageView.layer.borderWidth = 1
        
        
              return cell
    }
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(storyboard: .Main)
        let subsectionVC : InstagramStoryDetailViewController = storyboard.instantiateViewController()
        navController = UINavigationController(rootViewController: subsectionVC) // Creating a
        navController.isNavigationBarHidden = true
       
        self.present(navController, animated:true, completion: nil)
        
    }
    
    
    // MARK : TableView Delegates
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
     func numberOfSections(in tableView:UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramStoriesTableViewCell", for: indexPath as IndexPath) as! InstagramStoriesTableViewCell
        
        cell.imgView?.image = UIImage(named : images[indexPath.row])
        cell.nameLabel.text = name[indexPath.row]

        return cell
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

