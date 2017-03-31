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



class GameViewController: UIViewController {
//    var delegate: NavBarDelegate?
//    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
//        if let view = self.view as! SKView? {
//            view.isPaused = true
//        }
//    }
//    
//    @IBAction func startPressed(_ sender: UIBarButtonItem) {
//        if let view = self.view as! SKView? {
//            view.isPaused = false
//        }
//    }
    
//        var tempoSlider : UISlider?
//        let velocities = [25, 50, 75, 100, 125, 150, 175, 200]
//        let originalVelocity = 100
//    
//    
//        func sliderTouched(sender : UISlider) {
//            print ("=====Slider Sender: \(sender)")
//            // round the slider position to the nearest index of the numbers array
//            let index = (Int(tempoSlider!.value + 0.5))
//            tempoSlider?.setValue(Float(index), animated: false)
//            var curVelocity = velocities[index]; // <-- This numeric value you want
//            if originalVelocity != index{
//                print("new velocity:\(index)")
//                print("old velocity: \(curVelocity)")
//                curVelocity = index
//            }
//        }
    
    var indexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print (indexPath?.row)
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.scaleMode = .aspectFill
                if let view = self.view as! SKView? {
                    sceneNode.indexPath = indexPath
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
//                //: Add tempo slider (not connected to HUD)
//                tempoSlider = UISlider(frame: CGRect(x: view.frame.width/2, y: 23, width: 200, height: 50))
//                self.view?.addSubview(tempoSlider!)
//        
//                //: Configure the tempo slider
//                    // slider values go from 0 to the number of values in your numbers array
//                let numberOfSteps = Float(velocities.count - 1)
//                tempoSlider!.maximumValue = numberOfSteps;
//                tempoSlider!.minimumValue = 0;
//        
//                    // As the slider moves it will continously call the -valueChanged:
//                tempoSlider!.isContinuous = true; // false makes it call only once you let go
//                tempoSlider!.addTarget(self, action: #selector(sliderTouched), for: .valueChanged)

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
