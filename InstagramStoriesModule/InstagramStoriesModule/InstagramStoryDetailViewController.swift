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

protocol SelecteingNextStoriesDelegate: class {
    func selectNextstories()
   }

class InstagramStoryDetailViewController: UIViewController, SegmentedProgressBarDelegate {
    weak var delegate: SelecteingNextStoriesDelegate?
    private let iv = UIImageView()
    private var playerController = AVPlayerViewController()
    var images  = [] as NSArray
    private var spb: SegmentedProgressBar!
    private var count : Int!
    var isVideo : Bool = false
    var videoDuration : TimeInterval!
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
        if isVideo == true{
        spb.duration = videoDuration
        }
        view.addSubview(spb)
        spb.startAnimation()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))
       }
    
    func didTapCancelBuuton() {
    self.dismiss(animated: false, completion: nil)
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
        delegate?.selectNextstories()
    }
    
    @objc private func tappedView() {
         spb.isPaused = !spb.isPaused
         updateImage(index: count + 1)
    }
    
    private func updateImage(index: Int) {
        if(images.count > index){
        if (images[index] as! String).range(of: "mp4") != nil{
        iv.isHidden = true
        playerController.view.isHidden = false
        playVideo(videoName: images[index] as! String as NSString)
        }
        else{
            isVideo = false
            iv.isHidden = false
            playerController.view.isHidden = true
            iv.frame = view.bounds
            iv.contentMode = .scaleAspectFill
            self.view.addSubview(iv)
            
            let button = UIButton(frame: CGRect(x: self.view.frame.size.width-80, y: 40, width: 40, height: 40))
            button.setImage(UIImage(named: "back"), for: .normal)
            button.addTarget(self, action: #selector(didTapCancelBuuton), for: .touchUpInside)
            self.view.addSubview(button)
            self.view.bringSubview(toFront: button)



            iv.image = UIImage(named : images[index] as! String)
            if index > 0{
             self.view.bringSubview(toFront: spb)
             spb.duration = 5   
            }
            
        }
    
        count = index
        }
    }

    private func playVideo(videoName : NSString) {
        let videoExtention = videoName.pathExtension
        let videoPrefix = videoName.deletingPathExtension
        guard let path = Bundle.main.path(forResource: videoPrefix, ofType:videoExtention) else {
            debugPrint("\(videoPrefix).\(videoExtention) not found")
            return
        }
        isVideo = true
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let asset = AVURLAsset.init(url: URL(fileURLWithPath: path))
        let duration = asset.duration.seconds
        videoDuration = duration
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false
        playerController.view.frame = CGRect(x:0,y:0,width : self.view.frame.size.width,height : self.view.frame.size.height)
        self.view.addSubview(playerController.view)
        player.play()
        if spb != nil{
            spb.duration = duration
            self.view.bringSubview(toFront: spb)
        }
        let button = UIButton(frame: CGRect(x: self.view.frame.size.width-80, y: 40, width: 40, height: 40))
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(didTapCancelBuuton), for: .touchUpInside)
        self.view.addSubview(button)
        self.view.bringSubview(toFront: button)
    NotificationCenter.default.addObserver(self, selector: #selector(InstagramStoryDetailViewController.finishVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        }
    
    func finishVideo(){
        updateImage(index: count)
        print("Video Finished")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
