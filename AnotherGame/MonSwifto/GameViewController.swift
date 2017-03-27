//
//  GameViewController.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Build the menu scene:
        
        let menuScene = BossScene()
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        menuScene.size = view.bounds.size
        menuScene.scaleMode = SKSceneScaleMode.resizeFill
        skView.presentScene(menuScene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
