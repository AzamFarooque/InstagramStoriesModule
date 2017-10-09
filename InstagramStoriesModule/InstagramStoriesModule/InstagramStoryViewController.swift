//
//  InstagramStoryViewController.swift
//  InstagramStoriesModule
//
//  Created by Farooque on 05/10/17.
//  Copyright © 2017 Quintype. All rights reserved.
//

import UIKit


class InstagramStoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,SelecteingNextStoriesDelegate {
    @IBOutlet weak var storyCollectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    var navController : UINavigationController!
    var selectedIndex : Int!
    var automaticSelection : Bool = false
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
    
    // Pragma Mark : - CollectionView Deleagtes
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstagramStoryCollectionViewCell", for: indexPath as IndexPath) as! InstagramStoryCollectionViewCell
        cell.backgroundColor = UIColor.clear
        if indexPath.row == 0{
            cell.addButton.isHidden = false
        }else{
            cell.addButton.isHidden = true
        }
        cell.imageView.image = UIImage(named : images[indexPath.row])
        cell.nameLabel.text = name[indexPath.row]
        cell.imageView.layer.cornerRadius = 45
        cell.imageView.clipsToBounds = true
        cell.imageView.layer.borderColor = UIColor.red.cgColor
        cell.imageView.layer.borderWidth = 1
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let storyboard = UIStoryboard(storyboard: .Main)
        let subsectionVC : InstagramStoryDetailViewController = storyboard.instantiateViewController()
        navController = UINavigationController(rootViewController: subsectionVC) // Creating a
        navController.isNavigationBarHidden = true
        if indexPath.row == 0{
            subsectionVC.images = ["Image","giphy.mp4","Image-1"]
        }
        if indexPath.row == 1{
            subsectionVC.images = ["giphy.mp4","Image","open_sign.mp4"]
        }
        if indexPath.row == 2{
            subsectionVC.images = ["Image"]
        }
        if indexPath.row == 3{
            subsectionVC.images = ["Image-3","Image-4","Image-5"]
        }
        if indexPath.row == 4{
            subsectionVC.images = ["Image","Image-1","Image-2","Image-3","Image-4","Image-5"]
        }
        if indexPath.row == 5{
            subsectionVC.images = ["Image","Image-1","Image-2","Image-3","Image-4","Image-5","Image-6","Image-7","Image-8"]
        }
        if indexPath.row == 6{
            subsectionVC.images = ["Image-5","Image-6","Image-7","Image-8"]
        }
        if indexPath.row == 7{
            subsectionVC.images = ["Image-7","Image-8"]
        }
        if indexPath.row == 8{
            subsectionVC.images = ["Image"]
        }
        subsectionVC.delegate = self
        if automaticSelection == true{
            subsectionVC.modalTransitionStyle = .flipHorizontal
            self.present(navController, animated:true, completion: nil)
            automaticSelection = false
        }else{
           self.present(navController, animated:false, completion: nil)
        }
        
    }
    
    // Pragma MARK : TableView Delegates
    
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
    
    // Pragme Mark :- SelecteingNextStoriesDelegate Method
    
    func selectNextstories(){
        if selectedIndex + 1 < images.count{
            automaticSelection = true
            let indexPathForFirstRow = IndexPath(row: selectedIndex + 1, section: 0)
            storyCollectionView.selectItem(at: indexPathForFirstRow, animated: false, scrollPosition: UICollectionViewScrollPosition.left)
            self.collectionView(storyCollectionView, didSelectItemAt: indexPathForFirstRow)
            
        }
        return
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
