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

class GameScene: SKScene, SKPhysicsContactDelegate {
    var indexPath : NSIndexPath?
    let hud = HUD()
    let cam = SKCameraNode()
    var lastTouch: CGPoint? = nil
//    let C3Sound = SKAction.playSoundFileNamed("Sound/C3.mp3", waitForCompletion: false)
//    let C4Sound = SKAction.playSoundFileNamed("Sound/C4.mp3", waitForCompletion: false)
//    let ASound = SKAction.playSoundFileNamed("Sound/A.mp3", waitForCompletion: false)
//    let AsSound = SKAction.playSoundFileNamed("Sound/A#.mp3", waitForCompletion: false)
//    let BSound = SKAction.playSoundFileNamed("Sound/B.mp3", waitForCompletion: false)
//    let CsSound = SKAction.playSoundFileNamed("Sound/C#.mp3", waitForCompletion: false)
//    let DSound = SKAction.playSoundFileNamed("Sound/D.mp3", waitForCompletion: false)
//    let ESound = SKAction.playSoundFileNamed("Sound/E.mp3", waitForCompletion: false)
//    let FSound = SKAction.playSoundFileNamed("Sound/F.mp3", waitForCompletion: false)
//    let DsSound = SKAction.playSoundFileNamed("Sound/D#.mp3", waitForCompletion: false)
//    let FsSound = SKAction.playSoundFileNamed("Sound/F#.mp3", waitForCompletion: false)
//    let GSound = SKAction.playSoundFileNamed("Sound/G.mp3", waitForCompletion: false)
//    let GsSound = SKAction.playSoundFileNamed("Sound/G#.mp3", waitForCompletion: false)
    var mySprite : SKSpriteNode!
    var wall : SKSpriteNode!
//    var musicNote = MusicNote!
    var musicNoteG = GrayNote()
//    var musicNote2 : SKSpriteNode!
//    var activeNotes1 = [Bool]()
//    var activeNotes2 = [Bool]()
    let keys = ["C3", "C4", "A", "A#", "B", "C#", "D", "E", "F", "D#", "F#", "G", "G#"]
    let keysY = [195, 165, 135, 105, 75, 45, 15, -15, -45, -75, -105, -135, -165, -195]
    
    func printIP() {
        print(indexPath?.row)
    }
    
    override func didMove(to view: SKView) {
        self.camera = cam
        self.addChild(self.camera!)
        self.camera!.zPosition = 50
        hud.createHudNodes(screenSize: self.size)
        self.camera!.addChild(hud)
        
        self.physicsWorld.contactDelegate = self
        
        //: Add the vertical time line
        mySprite = SKSpriteNode(color: .red, size: CGSize(width: 2, height: self.frame.height))
        mySprite.position = CGPoint(x: -self.frame.width/2 + 10, y: 0)
        mySprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 2, height: mySprite.size.height))
        mySprite.physicsBody?.isDynamic = true
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
        wall.position = CGPoint(x: 300, y: 0)
        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 0.1, height: self.frame.height))
        wall.physicsBody?.isDynamic = false
        wall.physicsBody?.friction = 0
        wall.physicsBody?.categoryBitMask = PhysicsCategory.wall.rawValue
        wall.name = "rightWall"
        self.addChild(wall)
        
        //: Create music note nodes to use for touches
        printIP()   //WHY IS THIS NIL??!!
        if indexPath?.row == 0 {
            for num in 0...12 {
                let MNote1 = MusicNote(name: keys[num], status: false, position: CGPoint(x: -100, y: keysY[num]))
                let MNote2 = MusicNote(name: keys[num], status: true, position: CGPoint(x: 0, y: keysY[num]))
                let MNote3 = MusicNote(name: keys[num], status: false, position: CGPoint(x: 100, y: keysY[num]))
                self.addChild(MNote1)
                self.addChild(MNote2)
                self.addChild(MNote3)
            }
        } else if indexPath?.row == 1 {
            for num in 0...12 {
                let MNote1 = MusicNote(name: keys[num], status: true, position: CGPoint(x: -100, y: keysY[num]))
                let MNote2 = MusicNote(name: keys[num], status: false, position: CGPoint(x: 0, y: keysY[num]))
                let MNote3 = MusicNote(name: keys[num], status: false, position: CGPoint(x: 100, y: keysY[num]))
                self.addChild(MNote1)
                self.addChild(MNote2)
                self.addChild(MNote3)
            }
        } else {
            for num in 0...12 {
                let MNote1 = MusicNote(name: keys[num], status: false, position: CGPoint(x: -100, y: keysY[num]))
                let MNote2 = MusicNote(name: keys[num], status: false, position: CGPoint(x: 0, y: keysY[num]))
                let MNote3 = MusicNote(name: keys[num], status: false, position: CGPoint(x: 100, y: keysY[num]))
                self.addChild(MNote1)
                self.addChild(MNote2)
                self.addChild(MNote3)
            }
        }
        
//        print (arrNotes)
//        self.addChild(MusicNote(name: "test", status: false, position: CGPoint(x: 0, y: 70)))
//        musicNote.position = CGPoint(x: 0, y: 0)
//        self.addChild(musicNote)
//        musicNote.spawnchildren(position: CGPoint(x:0, y:70))
//        musicNote.spawnchildren(position: CGPoint(x:0, y:40))
//        musicNote.spawnchildren(position: CGPoint(x:0, y:10))
//        musicNote.spawnchildren(position: CGPoint(x:200, y:-30))
//
//        musicNote2 = SKSpriteNode(color: .green, size: CGSize(width: 10.0, height: 10.0))
//        musicNote2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10.0, height: 10.0))
//        musicNote2.physicsBody?.isDynamic = false
//        musicNote2.physicsBody?.friction = 0
//        musicNote2.physicsBody?.affectedByGravity = false
//        musicNote2.physicsBody?.categoryBitMask = PhysicsCategory.note.rawValue
//        musicNote2.name = "music_note"
//        musicNote2.position = CGPoint(x: -100, y: 0)
//        self.addChild(musicNote2)
    }

    //: Touch Events
//    func touchDown(atPoint pos : CGPoint) {
//        print ("note placed")
//        if let n = self.musicNote2?.copy() as! SKSpriteNode? {
//            n.position = pos
//            self.addChild(n)
//        }
//    }
    
    override func update(_ currentTime: TimeInterval) {
//        mySprite.physicsBody?.velocity = CGVector(dx: 100, dy: 0)
//        print("====vel: \(mySprite.physicsBody?.velocity)")
        printIP()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //: Create a green square
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            lastTouch = location
            if let gameSprite = nodeTouched as? GameSprite {
//                print (gameSprite)
                gameSprite.onTap()
            }
            if nodeTouched.name == "start" {
                hud.changebutton()
                if mySprite.physicsBody?.velocity == CGVector(dx:0, dy: 0) {
                    mySprite.physicsBody?.velocity = CGVector(dx:100, dy: 0)
                }
                else {
                    mySprite.physicsBody?.velocity = CGVector(dx:0, dy: 0)
                }
            }
            else if nodeTouched.name == "restart" {
                mySprite.position = CGPoint(x: -self.frame.width/2 + 10, y: 0)
            }
//            else if nodeTouched.name != "music_note"{
//                print("else touched")
//                self.touchDown(atPoint: touch.location(in: self))
//            }
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
                mySprite.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                //print (contact.contactPoint)
            case PhysicsCategory.note.rawValue:
                if let noteName = contact.bodyB.node?.name {
                    let noteSound = SKAction.playSoundFileNamed("Sound/\(noteName).mp3", waitForCompletion: false)
                    self.run(noteSound)
                }
//                if Int((contact.bodyB.node?.position.y)!) > 0 && Int((contact.bodyB.node?.position.y)!) <= 200 {
//                    self.run(C3Sound)
//                } else {
//                    self.run(C4Sound)
//                }
            default:
                print("no contact")
        }
    }
}


enum PhysicsCategory : UInt32 {
    case line = 1
    case wall = 2
    case note = 3
    //case enemy = 8
}

