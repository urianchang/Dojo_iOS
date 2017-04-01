//
//  GameViewController.swift
//  Chorus
//
//  Created by Carolyn Yen on 3/27/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreData

class GameViewController: UIViewController {
    var delegate: GameDelegate?
    var tempo: Int16? = 100
    var arr : [Array<Bool>]? = [[false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false],
                                [false, false, false, false, false, false, false]]
    
    var indexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.scaleMode = .aspectFill
                sceneNode.gameviewcontroller = self
                if let view = self.view as! SKView? {
                    sceneNode.indexPath = indexPath
                    sceneNode.testArr1 = (arr)!
                    sceneNode.curVelocity = Int(tempo!)
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    func itemsaved(title: String, instrument: String, tempo: Int16, song: NSObject, indexpath: NSIndexPath?){
        self.delegate?.itemsaved(title: title, instrument: instrument, tempo: tempo, song: song, indexpath: indexpath)
        print("gameviewcontroller save")
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
