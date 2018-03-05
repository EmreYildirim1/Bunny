//
//  GoogleAdViewController.swift
//  Bunny
//
//  Created by Emre Yıldırım on 04/09/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds

class GoogleAdViewController: UIViewController, GADRewardBasedVideoAdDelegate {
    
    var currentScene: SKScene!
    
    var isRewardReceived: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = SKView()
        
        GADRewardBasedVideoAd.sharedInstance().delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        super.viewDidAppear(animated)
        
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
        else {
            GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                        withAdUnitID: "ca-app-pub-4824390896428706~4066111759")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        
        isRewardReceived = true
        
        let skView = self.view as! SKView!
            
        let scene = self.currentScene
        scene?.view?.isPaused = false
        scene?.scaleMode = .aspectFit
            
        skView?.presentScene(scene)
    
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: "ca-app-pub-4824390896428706~4066111759")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        if !isRewardReceived {
            let skView = self.view as! SKView!
            
            let scene = MainMenu(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFit
            
            skView?.presentScene(scene)
        }
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
        showLoadError()
    }
    
    func showLoadError() {
        let alert = UIAlertController(title: "Alert", message: "Internet Connection Problem", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            let skView = self.view as! SKView!
            let scene = GameOver(fileNamed: "GameOver")
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
