//
//  GameScene.swift
//  comeFlyWithMe
//
//  Created by Urian Chang on 3/10/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //: Variables that will be used
    var skyNode : SKSpriteNode      // Sky shown
    var skyNodeNext : SKSpriteNode  // Sky queued
    var cloudsNode : SKSpriteNode   // Clouds shown
    var cloudsNodeNext : SKSpriteNode   // Clouds queued
    var groundNode : SKSpriteNode       // Ground shown
    var groundNodeNext : SKSpriteNode   // Ground queued
    var lastFrameTime : TimeInterval = 0    // Time of last frame
    var deltaTime : TimeInterval = 0    // Time since last frame
    
    override init(size: CGSize) {
        //: Check for current time
        let current = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let currentHour = formatter.string(from: current as Date)
        //        let currentHour = "8"     //Use for QA
        print ("Current hour is \(currentHour)")
        
        //: Display appropriate sky background based on time
        var bgname = String()
        if Int(currentHour)! > 7 && Int(currentHour)! < 18 {
            bgname = "daySky.png"
        } else {
            bgname = "nightSky.png"
        }
        
        //: Prep sky layer
        skyNode = SKSpriteNode(imageNamed: bgname)
        skyNode.size = size
        skyNode.position = CGPoint(x: size.width/2, y: size.height/2)
        skyNodeNext = skyNode.copy() as! SKSpriteNode
        skyNodeNext.position = CGPoint(x: skyNode.position.x + skyNode.size.width, y: skyNode.position.y)
        
        //: Prep cloud layer
        cloudsNode = SKSpriteNode(imageNamed: "clouds.png")
        cloudsNode.size = size
        cloudsNode.position = CGPoint(x: size.width/2, y: size.height/2)
        cloudsNodeNext = cloudsNode.copy() as! SKSpriteNode
        cloudsNodeNext.position = CGPoint(x: cloudsNode.position.x + cloudsNode.size.width, y: cloudsNode.position.y)
        
        //: Prep ground layer
        groundNode = SKSpriteNode(imageNamed: "ground.png")
        groundNode.size = size
        groundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        groundNodeNext = groundNode.copy() as! SKSpriteNode
        groundNodeNext.position = CGPoint(x: groundNode.position.x + groundNode.size.width, y: groundNode.position.y)
        
        
        super.init(size: size)
        
        //: Add background layers to the scene
        self.addChild(skyNode)
        self.addChild(skyNodeNext)
        
        self.addChild(cloudsNode)
        self.addChild(cloudsNodeNext)
        
        self.addChild(groundNode)
        self.addChild(groundNodeNext)
    }
    
    //: Borrowed code... I think this is a catch for in case init isn't run
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    //: Helper function to move the background layers
    func moveSprite(sprite : SKSpriteNode,
                    nextSprite : SKSpriteNode, speed : Float) -> Void {
        var newPosition = CGPoint.zero
        
        // For both the sprite and its duplicate:
        for spriteToMove in [sprite, nextSprite] {
            
            // Shift the sprite leftward based on the speed
            newPosition = spriteToMove.position
            newPosition.x -= CGFloat(speed * Float(deltaTime))
            spriteToMove.position = newPosition
            
            // If this sprite is now offscreen (i.e., its rightmost edge is
            // farther left than the scene's leftmost edge):
            if spriteToMove.frame.maxX < self.frame.minX {
                
                // Shift it over so that it's now to the immediate right
                // of the other sprite.
                // This means that the two sprites are effectively
                // leap-frogging each other as they both move.
                spriteToMove.position =
                    CGPoint(x: spriteToMove.position.x +
                        spriteToMove.size.width * 2,
                            y: spriteToMove.position.y)
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // First, update the delta time values:
        // If we don't have a last frame time value, this is the first frame,
        // so delta time will be zero.
        if lastFrameTime <= 0 {
            lastFrameTime = currentTime
        }
        
        // Update delta time
        deltaTime = currentTime - lastFrameTime
        
        // Set last frame time to current time
        lastFrameTime = currentTime
        
        // Next, move each of the layers.
        // Objects that should appear move slower than foreground objects.
        self.moveSprite(sprite: skyNode, nextSprite:skyNodeNext, speed:25.0)
        self.moveSprite(sprite: cloudsNode, nextSprite:cloudsNodeNext,
                        speed:50.0)
        self.moveSprite(sprite: groundNode, nextSprite:groundNodeNext, speed:75.0)
    }
}


