//
//  ViewController.swift
//  YoureSuchA
//
//  Created by Harry Huang on 18/12/2014.
//  Copyright (c) 2014 HHH. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    let iPhone4Height:CGFloat = 480.0
    let kOriginalPhoneScreenHeight:CGFloat = 702 * 0.6;
    let kOriginalPhoneScreenWidth:CGFloat = 396 * 0.6;
    
    var moviePlayer:MPMoviePlayerController!
    var shouldShowMovie:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setupMovie", name: UIApplicationDidBecomeActiveNotification, object: nil)
        setupMoviePlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var frameAdded = false
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupMoviePlayer()
    {
        var videoURL:NSURL = NSBundle.mainBundle().URLForResource("instructions", withExtension: "mov")!
        
        self.moviePlayer = MPMoviePlayerController(contentURL: videoURL)
        self.moviePlayer.controlStyle = MPMovieControlStyle.None
        self.moviePlayer.scalingMode = MPMovieScalingMode.AspectFit
        self.view.addSubview(self.moviePlayer.view)
        self.moviePlayer.shouldAutoplay = true
        self.moviePlayer.repeatMode = MPMovieRepeatMode.One
    }
    
    func setupMovie()
    {
        var phoneScalingFactor:CGFloat = UIScreen.mainScreen().applicationFrame.size.height/self.iPhone4Height
        
        var x:CGFloat = (self.view.bounds.size.width - self.kOriginalPhoneScreenWidth * phoneScalingFactor)/2
        var y:CGFloat = (self.view.bounds.size.height - self.kOriginalPhoneScreenHeight * phoneScalingFactor)/2

        self.moviePlayer.view.frame = CGRect(x: x, y: y, width: self.kOriginalPhoneScreenWidth * phoneScalingFactor, height: self.kOriginalPhoneScreenHeight * phoneScalingFactor)
        
        self.moviePlayer.play()
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        shouldShowMovie = false
        self.moviePlayer.stop()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        shouldShowMovie = true
        self.setupMovie()
    }

    
}

