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
    var storiesArray : NSArray!
    @IBOutlet weak var storiesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 1
        headerView.layer.masksToBounds = false
        headerView.layer.shadowOffset = CGSize.zero
        fetchStories()
    }
    
       func fetchStories(){
        InstagramUserServices.fetchStoriesList(){ (responseObject:NSArray?, error:NSError?,total) in
            if ((error) != nil) {
                print("Error logging you in!")
            } else {
                print("got it..")
                self.storiesArray = responseObject
                storyCollectionView.delegate = self
                storyCollectionView.dataSource = self
                storyCollectionView.reloadData()
                storiesTableView.delegate = self
                storiesTableView.dataSource = self
                storiesTableView.reloadData()

               
            }
        }
    }

    
    // Pragma Mark : - CollectionView Deleagtes
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesArray.count
    }
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstagramStoryCollectionViewCell", for: indexPath as IndexPath) as! InstagramStoryCollectionViewCell
        
        let section:InstagramStoriesModel=storiesArray[indexPath.row] as! InstagramStoriesModel
        
        cell.backgroundColor = UIColor.clear
        if indexPath.row == 0{
            cell.addButton.isHidden = false
        }else{
            cell.addButton.isHidden = true
        }
       
        cell.imageView.image = UIImage(named : section.images!)
        cell.nameLabel.text = section.name
        cell.imageView.layer.cornerRadius = 45
        cell.imageView.clipsToBounds = true
        cell.imageView.layer.borderColor = UIColor.red.cgColor
        cell.imageView.layer.borderWidth = 1
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        let section:InstagramStoriesModel=storiesArray[indexPath.row] as! InstagramStoriesModel
        
        let storyboard = UIStoryboard(storyboard: .Main)
        let subsectionVC : InstagramStoryDetailViewController = storyboard.instantiateViewController()
        navController = UINavigationController(rootViewController: subsectionVC) // Creating a
        navController.isNavigationBarHidden = true
        subsectionVC.images = section.storiesArray!
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
        return storiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstagramStoriesTableViewCell", for: indexPath as IndexPath) as! InstagramStoriesTableViewCell
        
        let section:InstagramStoriesModel=storiesArray[indexPath.row] as! InstagramStoriesModel
        cell.imgView?.image = UIImage(named : section.images!)
        cell.nameLabel.text = section.name!
        
        return cell
    }
    
    // Pragme Mark :- SelecteingNextStoriesDelegate Method
    
    func selectNextstories(){
        if selectedIndex + 1 < storiesArray.count{
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
