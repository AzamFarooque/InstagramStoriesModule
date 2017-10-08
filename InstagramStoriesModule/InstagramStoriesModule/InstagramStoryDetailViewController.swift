//
//  InstagramStoryDetailViewController.swift
//  InstagramStoriesModule
//
//  Created by Farooque on 08/10/17.
//  Copyright © 2017 Quintype. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class InstagramStoryDetailViewController: UIViewController, SegmentedProgressBarDelegate {

    private let iv = UIImageView()
    private var playerController = AVPlayerViewController()
    private let images = ["Image","Image-1","giphy.mp4","Image-2","Image-3","Image-4","Image-5","Image-6","Image-7","Image-8","giphy.mp4"]
    private var spb: SegmentedProgressBar!
    private var count : Int!
    @IBOutlet weak var storyDetailCollectionView: UICollectionView!
    
    
       override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor.white
        
        
        updateImage(index: 0)
        
        spb = SegmentedProgressBar(numberOfSegments: images.count)
        spb.frame = CGRect(x: 15, y: 15, width: view.frame.width - 30, height: 4)
        spb.delegate = self
        spb.topColor = UIColor.white
        spb.bottomColor = UIColor.white.withAlphaComponent(0.25)
        spb.padding = 2
        view.addSubview(spb)
        
       
        
        spb.startAnimation()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))
       }
    
      func ratingButtonTapped() {
        self.dismiss(animated: false, completion: nil)
    }
    
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func segmentedProgressBarChangedIndex(index: Int) {
        print("Now showing index: \(index)")
        updateImage(index: index)
    }
    
    func segmentedProgressBarFinished() {
        print("Finished!")
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func tappedView() {
         spb.isPaused = !spb.isPaused
         updateImage(index: count + 1)
    }
    
    private func updateImage(index: Int) {
        
        if(images.count > index){
        
        if images[index].range(of: "mp4") != nil{
            
        iv.isHidden = true
        playerController.view.isHidden = false
        playVideo()
        }
        else{
            
            iv.isHidden = false
            playerController.view.isHidden = true
            iv.frame = view.bounds
            iv.contentMode = .scaleAspectFill
            self.view.addSubview(iv)
            
            let button = UIButton(frame: CGRect(x: self.view.frame.size.width-80, y: 40, width: 40, height: 40))
            button.setImage(UIImage(named: "back"), for: .normal)
            button.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
            self.view.addSubview(button)
            self.view.bringSubview(toFront: button)



            iv.image = UIImage(named : images[index])
            if index > 0{
             self.view.bringSubview(toFront: spb)
             spb.duration = 5   
            }
            
        }
    
       count = index
        }
           }

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "giphy", ofType:"mp4") else {
            debugPrint("giphy.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let asset = AVURLAsset.init(url: URL(fileURLWithPath: path))
        let duration = asset.duration.seconds
        
        spb.duration = duration
       
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false
        playerController.view.frame = CGRect(x:0,y:0,width : self.view.frame.size.width,height : self.view.frame.size.height)
        self.view.addSubview(playerController.view)
        player.play()
        self.view.bringSubview(toFront: spb)
        
        let button = UIButton(frame: CGRect(x: self.view.frame.size.width-80, y: 40, width: 40, height: 40))
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
        self.view.addSubview(button)
        self.view.bringSubview(toFront: button)

        
    NotificationCenter.default.addObserver(self, selector: #selector(InstagramStoryDetailViewController.finishVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)

        }
    func finishVideo()
    {
      //  self.dismiss(animated: false, completion: nil)
        updateImage(index: count+1)
        print("Video Finished")
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
