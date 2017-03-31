//
//  GameScene.swift
//  Chorus
//
//  Created by Carolyn Yen on 3/27/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import CoreData

class GameScene: SKScene, SKPhysicsContactDelegate {
    var indexPath : NSIndexPath?
    let hud = HUD()
    let cam = SKCameraNode()
    var lastTouch: CGPoint? = nil
    let C3Sound = SKAction.playSoundFileNamed("Sound/C3.mp3", waitForCompletion: false)
    let C4Sound = SKAction.playSoundFileNamed("Sound/C4.mp3", waitForCompletion: false)
    let ASound = SKAction.playSoundFileNamed("Sound/A.mp3", waitForCompletion: false)
    let AsSound = SKAction.playSoundFileNamed("Sound/A#.mp3", waitForCompletion: false)
    let BSound = SKAction.playSoundFileNamed("Sound/B.mp3", waitForCompletion: false)
    let CsSound = SKAction.playSoundFileNamed("Sound/C#.mp3", waitForCompletion: false)
    let DSound = SKAction.playSoundFileNamed("Sound/D.mp3", waitForCompletion: false)
    let ESound = SKAction.playSoundFileNamed("Sound/E.mp3", waitForCompletion: false)
    let FSound = SKAction.playSoundFileNamed("Sound/F.mp3", waitForCompletion: false)
    let DsSound = SKAction.playSoundFileNamed("Sound/D#.mp3", waitForCompletion: false)
    let FsSound = SKAction.playSoundFileNamed("Sound/F#.mp3", waitForCompletion: false)
    let GSound = SKAction.playSoundFileNamed("Sound/G.mp3", waitForCompletion: false)
    let GsSound = SKAction.playSoundFileNamed("Sound/G#.mp3", waitForCompletion: false)
    var mySprite : SKSpriteNode!
    var wall : SKSpriteNode!
    var instrument = false
    let keys = ["C3", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C4"]
    var keysY = [CGFloat]()
    var guitarstatus = false
    var tempoSlider : UISlider?
    let velocities = [25, 50, 75, 100, 125, 150, 175, 200]
    var curVelocity = 100
    weak var gameviewcontroller: GameViewController?
    
    let testArr1 = [[true, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true],
                    [false, false, false, false, true, false, true]]
    
    
    func sliderTouched(sender : UISlider) {
        //        print ("=====Slider Sender: \(sender)")
        print ("old velocity: \(curVelocity)")
        // round the slider position to the nearest index of the numbers array
        let index = (Int(tempoSlider!.value + 0.5))
        tempoSlider?.setValue(Float(index), animated: false)
        let newVelocity = velocities[index]; // <-- This numeric value you want
        if curVelocity != newVelocity {
            curVelocity = newVelocity
            hud.changetempo(tempo: curVelocity)
        }
    }

    
    override func didMove(to view: SKView) {
        let cameraOrigin = CGPoint(
            x: self.size.width / 2,
            y: self.size.height / 2 + 20)
        
//        keysY = [400, 372, 344, 316, 288, 260, 232, 204, 176, 148, 120, 92, 62]
        
        self.camera = cam
        self.addChild(self.camera!)
        self.camera!.zPosition = 50
        hud.createHudNodes(screenSize: self.size)
        self.camera!.addChild(hud)
        
        self.physicsWorld.contactDelegate = self
        
        //: Add the vertical time line
        mySprite = SKSpriteNode(color: .red, size: CGSize(width: 2.5, height: self.frame.height))
        mySprite.position = CGPoint(x: -self.frame.width/2 + 100, y: 0)
        mySprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 2.5, height: mySprite.size.height))
        mySprite.physicsBody?.isDynamic = true
        mySprite.zPosition = 30
        mySprite.physicsBody?.affectedByGravity = false
        mySprite.physicsBody?.friction = 0
        mySprite.physicsBody?.linearDamping = 0
        mySprite.physicsBody?.categoryBitMask = PhysicsCategory.line.rawValue
        mySprite.physicsBody?.contactTestBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.note.rawValue
        mySprite.physicsBody?.collisionBitMask = 0
        mySprite.name = "timeline"
        self.addChild(mySprite)
        mySprite.physicsBody?.velocity = CGVector(dx: 0, dy:0)
        
        //: Configure the wall edge
        wall = SKSpriteNode(color: .blue, size: CGSize(width: 1, height: self.frame.height))
        wall.position = CGPoint(x: self.frame.width/2 - 2, y: 0)
        wall.zPosition = 30
        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: self.frame.height))
        wall.physicsBody?.isDynamic = false
        wall.physicsBody?.friction = 0
        wall.physicsBody?.categoryBitMask = PhysicsCategory.wall.rawValue
        wall.name = "rightWall"
        self.addChild(wall)
        
        let screenXLeftOver = self.size.width - 100
        
        // pos1_pos2_name
        //arr[pos1][pos2] = !(arr[pos1][pos2])
        
        //: Create music note nodes to use for touches
        if indexPath?.row == 0 {
            for num in 0...12 {
                for i in 0...Int(screenXLeftOver/100) {
                    if num == 1 || num == 3 || num == 6 || num == 8 || num == 10 {
                        let MNote1 = MusicNote(name: keys[num], status: false, position: CGPoint(x: (-screenXLeftOver/2 + (CGFloat(i) * 78) + 100), y: cameraOrigin.y - (self.frame.height - (CGFloat(num) * (self.size.height - 58)/13))), size: CGSize(width: 80 , height: (self.size.height - 58)/13), gray: true)
                        self.addChild(MNote1)
                    }
                    else {
                        let MNote1 = MusicNote(name: keys[num], status: false, position: CGPoint(x: (-screenXLeftOver/2 + (CGFloat(i) * 78) + 100), y: cameraOrigin.y - (self.frame.height - (CGFloat(num) * (self.size.height - 58)/13))), size: CGSize(width: 80 , height: (self.size.height - 58)/13), gray: false)
                        self.addChild(MNote1)
                    }
                }
            }
        } else if indexPath?.row == 1 {
            for num in 0...12 {
                for i in 0...Int(screenXLeftOver/100) {
                    if num == 1 || num == 3 || num == 6 || num == 8 || num == 10 {
                        let MNote1 = MusicNote(name: keys[num], status: false, position: CGPoint(x: (-screenXLeftOver/2 + (CGFloat(i) * 78) + 100), y: cameraOrigin.y - (self.frame.height - (CGFloat(num) * (self.size.height - 58)/13))), size: CGSize(width: 80 , height: (self.size.height - 58)/13), gray: true)
                        self.addChild(MNote1)
                    }
                    else {
                        let MNote1 = MusicNote(name: keys[num], status: false, position: CGPoint(x: (-screenXLeftOver/2 + (CGFloat(i) * 78) + 100), y: cameraOrigin.y - (self.frame.height - (CGFloat(num) * (self.size.height - 58)/13))), size: CGSize(width: 80 , height: (self.size.height - 58)/13), gray: false)
                        self.addChild(MNote1)
                    }
                }
            }
        } else {
            for num in 0...12 {
                for i in 0...Int(screenXLeftOver/100) {
                    if num == 1 || num == 3 || num == 6 || num == 8 || num == 10 {
                        let MNote1 = MusicNote(name: String(num) + "_" + String(i) + "_" + keys[num], status: testArr1[num][i], position: CGPoint(x: (-screenXLeftOver/2 + (CGFloat(i) * 78) + 100), y: cameraOrigin.y - (self.frame.height - (CGFloat(num) * (self.size.height - 58)/13))), size: CGSize(width: 80 , height: (self.size.height - 58)/13), gray: true)
                        self.addChild(MNote1)
                    }
                    else {
                        let MNote1 = MusicNote(name: String(num) + "_" + String(i) + "_" + keys[num], status: testArr1[num][i], position: CGPoint(x: (-screenXLeftOver/2 + (CGFloat(i) * 78) + 100), y: cameraOrigin.y - (self.frame.height - (CGFloat(num) * (self.size.height - 58)/13))), size: CGSize(width: 80 , height: (self.size.height - 58)/13), gray: false)
                        self.addChild(MNote1)
                    }
                }
            }
        }
        
        //: Add tempo slider (not connected to HUD)
        tempoSlider = UISlider(frame: CGRect(x: view.frame.width/2, y: 5, width: 200, height: 30))
        self.view?.addSubview(tempoSlider!)
        
        //: Configure the tempo slider
        // slider values go from 0 to the number of values in your numbers array
        let numberOfSteps = Float(velocities.count - 1)
        tempoSlider!.maximumValue = numberOfSteps;
        tempoSlider!.minimumValue = 0;
        tempoSlider!.value = Float(3)
        
        // As the slider moves it will continously call the -valueChanged:
        tempoSlider!.isContinuous = true; // false makes it call only once you let go
        tempoSlider!.addTarget(self, action: #selector(sliderTouched), for: .valueChanged)
    
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    func resettiles(){
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.scaleMode = .aspectFill
                    sceneNode.indexPath = indexPath
                    self.view?.presentScene(sceneNode)
                    self.view?.ignoresSiblingOrder = true
                    self.view?.showsFPS = true
                    self.view?.showsNodeCount = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //: Create a green square
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            lastTouch = location
            if let gameSprite = nodeTouched as? GameSprite {
                print ()
                gameSprite.onTap()
            }
            if nodeTouched.name == "start" {
                hud.changebutton()
                if mySprite.physicsBody?.velocity == CGVector(dx:0, dy: 0) {
                    mySprite.physicsBody?.velocity = CGVector(dx:curVelocity, dy: 0)
                }
                else {
                    mySprite.physicsBody?.velocity = CGVector(dx:0, dy: 0)
                }
            }
            else if nodeTouched.name == "pC3" {
                
                self.run(C3Sound)
            }
            else if nodeTouched.name == "pCS" {
                self.run(CsSound)
            }
            else if nodeTouched.name == "pD" {
                self.run(DSound)
            }
            else if nodeTouched.name == "pDS" {
                self.run(DsSound)
            }
            else if nodeTouched.name == "pE" {
                self.run(ESound)
            }
            else if nodeTouched.name == "pF" {
                self.run(FSound)
            }
            else if nodeTouched.name == "pFS" {
                self.run(FsSound)
            }
            else if nodeTouched.name == "pG" {
                self.run(GSound)
            }
            else if nodeTouched.name == "pGS" {
                self.run(GsSound)
            }
            else if nodeTouched.name == "pA" {
                self.run(ASound)
            }
            else if nodeTouched.name == "pAS" {
                self.run(AsSound)
            }
            else if nodeTouched.name == "pB" {
                self.run(BSound)
            }
            else if nodeTouched.name == "pC4" {
                self.run(C4Sound)
            }
            else if nodeTouched.name == "restart" {
                mySprite.position = CGPoint(x: -self.frame.width/2 + 100, y: 0)
                hud.resetbutton()
            }
            else if nodeTouched.name == "clear" {
               resettiles()
            }
            else if nodeTouched.name == "change" {
                if instrument == false {
                    hud.showmenu()
                    instrument = true
                }
                else {
                    hud.hidemenu()
                    instrument = false
                }
            }
            else if nodeTouched.name == "piano" {
                guitarstatus = false
                hud.hidemenu()
                hud.switchinstrument(name: "piano")
                instrument = false
            }
            else if nodeTouched.name == "violin" {
                guitarstatus = true
                hud.hidemenu()
                hud.switchinstrument(name: "violin")
                instrument = false
            }
            else if nodeTouched.name == "save" {
                self.view?.presentScene(nil)
                self.removeAllChildren()
                self.removeAllActions()
                self.scene?.removeFromParent()
                self.gameviewcontroller?.itemsaved()
                self.gameviewcontroller?.performSegue(withIdentifier: "unwind", sender: nil)
                print("saved")
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let otherBody : SKPhysicsBody
        let lineMask = PhysicsCategory.line.rawValue
        
        if (contact.bodyA.categoryBitMask & lineMask) > 0 {
            otherBody = contact.bodyB
        }
        else {
            otherBody = contact.bodyA
        }
        
        switch otherBody.categoryBitMask {
            case PhysicsCategory.wall.rawValue:
                print("wall")
                mySprite.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                mySprite.removeFromParent()
                mySprite.position = CGPoint(x: -self.frame.width/2 + 100, y: 0)
                self.addChild(mySprite)
                mySprite.physicsBody?.velocity = CGVector(dx: curVelocity, dy: 0)
                //print (contact.contactPoint)
            case PhysicsCategory.note.rawValue:
                if let noteName = contact.bodyB.node?.name {
                    if guitarstatus == true  {
                        let note = "Guitar"+noteName
                        let noteSound = SKAction.playSoundFileNamed("Sound/\(note).caf", waitForCompletion: false)
                        self.run(noteSound)
                    }
                    else {
                        //: Need to repeat for Guitar...
                        let strArr = noteName.components(separatedBy: "_")
                        let noteSound = SKAction.playSoundFileNamed("Sound/\(strArr[2]).mp3", waitForCompletion: false)
                        self.run(noteSound)
                    }
                }
            default:
                print("no contact")
        }
    }
}

enum PhysicsCategory : UInt32 {
    case line = 1
    case wall = 2
    case note = 3
}

