//
//  InstagramStoryDetailViewController.swift
//  InstagramStoriesModule
//
//  Created by Farooque on 05/10/17.
//  Copyright © 2017 Quintype. All rights reserved.
//

import UIKit

class InstagramStoryDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var storyDetailCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyDetailCollectionView.delegate = self
        storyDetailCollectionView.dataSource = self

        // Do any additional setup after loading the view.
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
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width : self.view.frame.size.width , height : self.view.frame.size.height)
    }
    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
