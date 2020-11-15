//
//  GameViewController.swift
//  TTrukPuzzle
//
//  Created by Yana  on 2020-10-25.
//  Copyright © 2020 Yana . All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import StoreKit

let audio = AudioPlayer.sharedInstance()

class GameViewController: UIViewController {
    
    public static let appStoreConnector: AppStoreConnector = AppStoreConnector()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let massivProductov: [String] = ["Slikatoon.TTruckPuzzle.FullAccess"]
        GameViewController.appStoreConnector.triggerDelegateToRecieveProducts(massivProductov)
         if let view = self.view as! SKView? {
            // Load the SKScene from 'PreviewScene.sks'
         if let scene = SKScene(fileNamed: "Preview") {
            // Set the scale mode to scale to fit the window
         scene.scaleMode = .aspectFill
                              
         _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
          view.presentScene(scene)
        }
    }

    }

    @objc func update() {
        if let view = self.view as! SKView? {
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)
        }
             view.ignoresSiblingOrder = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
