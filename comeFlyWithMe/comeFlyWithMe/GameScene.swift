//
//  GameScene.swift
//  comeFlyWithMe
//
//  Created by Urian Chang on 3/10/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import SpriteKit
import GameplayKit

//: Vector math functions
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

class GameScene: SKScene {
    
    //: Variables that will be used
    var skyNode : SKSpriteNode      // Sky shown
    var skyNodeNext : SKSpriteNode  // Sky queued
    var cloudsNode : SKSpriteNode   // Clouds shown
    var cloudsNodeNext : SKSpriteNode   // Clouds queued
    var groundNode : SKSpriteNode       // Ground shown
    var groundNodeNext : SKSpriteNode   // Ground queued
    var airship : SKSpriteNode!     // Airship
    var lastFrameTime : TimeInterval = 0    // Time of last frame
    var deltaTime : TimeInterval = 0    // Time since last frame
    let shipCategory : UInt32 = 1 << 0
    let worldCategory : UInt32 = 1 << 1
    var gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, 0, 0))
    
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
        var bgmusic = String()
        if Int(currentHour)! > 7 && Int(currentHour)! < 18 {
            bgname = "daySky.png"
            bgmusic = "warm_breeze.mp3"
        } else {
            bgname = "nightSky.png"
            bgmusic = "starry_night.mp3"
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
        
        //: IMPORTANT
        super.init(size: size)
        
        //: Add background layers to the scene
        self.addChild(skyNode)
        self.addChild(skyNodeNext)
        
        self.addChild(cloudsNode)
        self.addChild(cloudsNodeNext)
        
        self.addChild(groundNode)
        self.addChild(groundNodeNext)
        
//        //: Add background music
//        let backgroundMusic = SKAudioNode(fileNamed: bgmusic)
//        backgroundMusic.autoplayLooped = true
//        addChild(backgroundMusic)
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
        //: Setup physics
        self.physicsWorld.gravity = CGVector(dx: -1.0, dy: 0)
        

        
        //: Add player's airship
        airship = SKSpriteNode(imageNamed: "myShip")
        airship.setScale(0.20)
        airship.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        airship.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: airship.size.width, height: airship.size.height))
        airship.physicsBody?.isDynamic = true
        airship.physicsBody?.allowsRotation = false
        airship.physicsBody?.categoryBitMask = shipCategory
        airship.physicsBody?.linearDamping = 1.0
        addChild(airship)
        
//        var gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, 0, 0))
//        if airship.position.y > size.height*0.5 {
//            gravityVectorY.removeFromParent()
//            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, -1, 0))
//        } else if airship.position.y < size.height*0.5 {
//            gravityVectorY.removeFromParent()
//            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, 1, 0))
//        }
        gravityVectorY.strength = 1.0
        addChild(gravityVectorY)
        
        //: Screen borders
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
//        //: Add balloons and friends
//        let redBall = SKSpriteNode(imageNamed: "redBalloon")
//        redBall.setScale(0.15)
//        let yellowBall = SKSpriteNode(imageNamed: "yellowBalloon")
//        yellowBall.setScale(0.15)
//        let pinkBall = SKSpriteNode(imageNamed: "pinkBalloon")
//        pinkBall.setScale(0.15)
//        let friend = SKSpriteNode(imageNamed: "hotAir")
//        friend.setScale(0.28)
//        
//        redBall.position = CGPoint(x: size.width * 0.3, y: size.height * 0.5)
//        yellowBall.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
//        pinkBall.position = CGPoint(x: size.width * 0.7, y: size.height * 0.5)
//        friend.position = CGPoint(x: size.width * 0.9, y: size.height * 0.5)
//        
//        addChild(redBall)
//        addChild(yellowBall)
//        addChild(pinkBall)
//        addChild(friend)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //: Use only one touch point
        guard let touch = touches.first else {
            return
        }
        airship.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        let touchLocation = touch.location(in: self)
//        print (touchLocation.x, touchLocation.y)
        let offset = touchLocation - airship.position
        let direction = offset.normalized()
//        print (offset.x, offset.y)
        airship.physicsBody?.applyImpulse(CGVector(dx: offset.x, dy: offset.y))
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
        
        if Int(airship.position.y) > Int(size.height*0.55) {
            print ("Above")
            // Trying move to vs gravity vector...didn't turn out like I wanted.
//            let actionMove = SKAction.move(to: CGPoint(x: size.width * 0.1, y: size.height * 0.5), duration: 2.0)
//            let actionMoveDone = SKAction.removeFromParent()
//            airship.run(SKAction.sequence([actionMove]))
            gravityVectorY.removeFromParent()
            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, -1, 0))
        } else if Int(airship.position.y) < Int(size.height*0.45) {
            print ("Below")
            gravityVectorY.removeFromParent()
            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, 1, 0))
        } else {
            print ("At the midpoint")
            gravityVectorY.removeFromParent()
            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, 0, 0))
        }
        gravityVectorY.strength = 1.0
        addChild(gravityVectorY)
        
        print (airship.position.y)
        
//        if Int(airship.position.y) == Int(size.height*0.5) {
//            print ("At the midpoint")
//            gravityVectorY.removeFromParent()
//            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, 0, 0))
//        } else if Int(airship.position.y) > Int(size.height*0.5) {
//            print ("Above")
//            gravityVectorY.removeFromParent()
//            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, -1, 0))
//        } else if Int(airship.position.y) < Int(size.height*0.5) {
//            print ("Below")
//            gravityVectorY.removeFromParent()
//            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, 1, 0))
//        }
//        gravityVectorY.strength = 1.0
//        addChild(gravityVectorY)
        
//        print (airship.position.y)
//        print (size.height*0.5)
        
        // Next, move each of the layers.
        // Objects that should appear move slower than foreground objects.
        self.moveSprite(sprite: skyNode, nextSprite:skyNodeNext, speed:25.0)
        self.moveSprite(sprite: cloudsNode, nextSprite:cloudsNodeNext,
                        speed:50.0)
        self.moveSprite(sprite: groundNode, nextSprite:groundNodeNext, speed:75.0)
    }
}


