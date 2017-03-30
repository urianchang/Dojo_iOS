//
//  GameScene.swift
//  Chorus
//
//  Created by Carolyn Yen on 3/27/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var mySprite : SKSpriteNode!
    var wall : SKSpriteNode!
    var musicNote : SKSpriteNode!
    
//    override init(size: CGSize) {
//        super.init(size: size)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("Not implemented")
//    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        //: Add the vertical time line
        mySprite = SKSpriteNode(color: .red, size: CGSize(width: 2, height: self.frame.height))
        mySprite.position = CGPoint(x: -self.frame.width/2 + 10, y: 0)
        mySprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 2, height: mySprite.size.height))
        mySprite.physicsBody?.isDynamic = true
        mySprite.physicsBody?.affectedByGravity = false
        mySprite.physicsBody?.usesPreciseCollisionDetection = true
        mySprite.physicsBody?.categoryBitMask = PhysicsCategory.line.rawValue
        mySprite.physicsBody?.contactTestBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.note.rawValue
        mySprite.physicsBody?.collisionBitMask = 0
        mySprite.name = "timeline"
        self.addChild(mySprite)
        mySprite.physicsBody?.velocity = CGVector(dx: 100, dy:0)
        
        //: Configure the wall edge
        wall = SKSpriteNode(color: .blue, size: CGSize(width: 1, height: self.frame.height))
        wall.position = CGPoint(x: 100, y: 0)
        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 0.1, height: self.frame.height))
        wall.physicsBody?.isDynamic = false
        wall.physicsBody?.categoryBitMask = PhysicsCategory.wall.rawValue
//        wall.physicsBody?.collisionBitMask = PhysicsCategory.line.rawValue
        wall.name = "rightWall"
        self.addChild(wall)
        
//        print ("Nodes on the scene: \(self.children)")
        
        //: Create music note node to use for touches 
            // Maybe wrap this up in a function that can be fed y-position of the touch to determine which note to use
        musicNote = SKSpriteNode(color: .green, size: CGSize(width: 10.0, height: 10.0))
        musicNote.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10.0, height: 10.0))
        musicNote.physicsBody?.isDynamic = false
        musicNote.physicsBody?.affectedByGravity = false
        musicNote.physicsBody?.categoryBitMask = PhysicsCategory.note.rawValue
//        musicNote.physicsBody?.collisionBitMask = 0
        musicNote.name = "music_note"
    }

    //: Touch Events
    func touchDown(atPoint pos : CGPoint) {
        print ("note placed")
//        musicNote = SKSpriteNode(color: .green, size: CGSize(width: 10.0, height: 10.0))
//        musicNote.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10.0, height: 10.0))
//        musicNote.physicsBody?.isDynamic = false
//        musicNote.physicsBody?.affectedByGravity = false
//        musicNote.physicsBody?.usesPreciseCollisionDetection = true
//        musicNote.physicsBody?.categoryBitMask = PhysicsCategory.note.rawValue
//        musicNote.name = "music_note"
//        self.addChild(musicNote)
        if let n = self.musicNote?.copy() as! SKSpriteNode? {
            n.position = pos
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //: Create a green square
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
//    override func sceneDidLoad() {
//        
//        self.physicsWorld.contactDelegate = self
//        
//        //: Add the vertical time line
//        mySprite = SKSpriteNode(color: .red, size: CGSize(width: 2, height: self.frame.height))
//        mySprite.position = CGPoint(x: -self.frame.width/2 + 10, y: 0)
//        mySprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 2, height: mySprite.size.height))
//        mySprite.physicsBody?.isDynamic = true
//        mySprite.physicsBody?.affectedByGravity = false
//        mySprite.physicsBody?.usesPreciseCollisionDetection = true
//        mySprite.physicsBody?.categoryBitMask = PhysicsCategory.line.rawValue
//        mySprite.physicsBody?.contactTestBitMask = PhysicsCategory.wall.rawValue
//        mySprite.name = "timeline"
//        self.addChild(mySprite)
//        mySprite.physicsBody?.velocity = CGVector(dx: 100, dy:0)
//        
//        //: Configure the wall edge
//        wall = SKSpriteNode(color: .blue, size: CGSize(width: 1, height: self.frame.height))
//        wall.position = CGPoint(x: 0, y: 0)
//        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 0.1, height: self.frame.height))
//        wall.physicsBody?.isDynamic = false
//        wall.physicsBody?.categoryBitMask = PhysicsCategory.wall.rawValue
//        wall.name = "rightWall"
//        self.addChild(wall)
//        
//        print (self.children)
////        [<SKSpriteNode> name:'timeline' texture:['nil'] position:{-358, 0} scale:{1.00, 1.00} size:{2, 414} anchor:{0.5, 0.5} rotation:0.00,
////            <SKSpriteNode> name:'rightWall' texture:['nil'] position:{0, 0} scale:{1.00, 1.00} size:{1, 414} anchor:{0.5, 0.5} rotation:0.00]
////        [<SKSpriteNode> name:'timeline' texture:['nil'] position:{-358, 0} scale:{1.00, 1.00} size:{2, 414} anchor:{0.5, 0.5} rotation:0.00,
////            <SKSpriteNode> name:'rightWall' texture:['nil'] position:{0, 0} scale:{1.00, 1.00} size:{1, 414} anchor:{0.5, 0.5} rotation:0.00,
////            <SKSpriteNode> name:'timeline' texture:['nil'] position:{-358, 0} scale:{1.00, 1.00} size:{2, 414} anchor:{0.5, 0.5} rotation:0.00,
////            <SKSpriteNode> name:'rightWall' texture:['nil'] position:{0, 0} scale:{1.00, 1.00} size:{1, 414} anchor:{0.5, 0.5} rotation:0.00]
//
//    }
    
    override func update(_ currentTime: TimeInterval) {
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
                print("======hit the wall======")
                print (contact.contactPoint)    //: This shows points of collision (for the wall, it detects top and bottom points of the rectangle)
            case PhysicsCategory.note.rawValue:
                print ("~~MUSIC~~")
            default:
                print("no contact")
        }
    }
}


enum PhysicsCategory : UInt32 {
    case line = 1
    case wall = 2
    case note = 3
    case enemy = 8
}

