//
//  GameScene.swift
//  comeFlyWithMe
//
//  Created by Urian Chang on 3/10/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import SpriteKit
import GameplayKit

//: Vector math functions (extending the basic ones)
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

class GameScene: SKScene, SKPhysicsContactDelegate {
    
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
    let shipCategory : UInt32 = 1 << 0  // Physics body category for airship
    let balloonCategory : UInt32 = 1 << 1   // Physics body category for balloon
    var gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, 0, 0)) // Vertical gravity vector
    var totalScore = 0  // Total score tracker
    var scoreLabelNode : SKLabelNode! // Score label
    var totalHighFives = 0  // Total high-fives tracker
    var highFiveLabelNode : SKLabelNode! // High-five counter label
    var totalBalloons = 0   // Total balloons saved
    var balloonsLabelNode : SKLabelNode! // Balloon counter label
    
    override init(size: CGSize) {
        //: Check for current time
        let current = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let currentHour = formatter.string(from: current as Date)
        //let currentHour = "20"     //Use for QA
        print ("Current hour is \(currentHour)")
        
        //: Display appropriate sky background based on time
        var bgname = String()
        var bgmusic = String()
        if Int(currentHour)! > 7 && Int(currentHour)! < 18 {
            bgname = "daySky.png"
            bgmusic = "warm_breeze.caf"
        } else {
            bgname = "nightSky.png"
            bgmusic = "night_sky.caf"
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
        
        //: Add background music
        let backgroundMusic = SKAudioNode(fileNamed: bgmusic)
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
    
    //: Borrowed code... I think this is a catch for in case init isn't run
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    //: Helper function to move the background layers
    func moveSprite(sprite : SKSpriteNode,
                    nextSprite : SKSpriteNode, speed : Float) -> Void {
        var newPosition = CGPoint.zero
        
        // For both the layer and its duplicate:
        for spriteToMove in [sprite, nextSprite] {
            
            // Shift the layer leftward based on the speed
            newPosition = spriteToMove.position
            newPosition.x -= CGFloat(speed * Float(deltaTime))
            spriteToMove.position = newPosition
            
            // If this layer is offscreen:
            if spriteToMove.frame.maxX < self.frame.minX {
                // Shift it over so that it's now to the immediate right of the current layer
                spriteToMove.position =
                    CGPoint(x: spriteToMove.position.x +
                        spriteToMove.size.width * 2,
                            y: spriteToMove.position.y)
            }
        }
    }
    
    override func didMove(to view: SKView) {
        //: Setup physics p.I
        self.physicsWorld.gravity = CGVector(dx: -5.0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
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
        
        //: Setup physics p.II
        gravityVectorY.strength = 1.0
        addChild(gravityVectorY)
        
        //: Screen borders
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        //: Create balloons indefinitely
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addBalloons),
                SKAction.wait(forDuration: 2.0)])
        ))
        
        //: Create the labels
        scoreLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabelNode.fontSize = 18.0
        scoreLabelNode.text = "Score: \(totalScore)"
        scoreLabelNode.position = CGPoint(x: scoreLabelNode.frame.maxX, y: 8)
        
        balloonsLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        balloonsLabelNode.text = "Balloons: \(totalBalloons)"
        balloonsLabelNode.fontSize = 18.0
        balloonsLabelNode.position = CGPoint(x: self.frame.midX, y: 8)
        
        highFiveLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        highFiveLabelNode.text = "High-fives: \(totalHighFives)"
        highFiveLabelNode.fontSize = 18.0
        highFiveLabelNode.position = CGPoint(x: self.frame.width - highFiveLabelNode.frame.maxX, y: 8)
        
        //: Add the labels
        addChild(scoreLabelNode)
        addChild(balloonsLabelNode)
        addChild(highFiveLabelNode)
    }
    
    //: Action when user touches the screen (moves the airship)
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //: Use only one touch point
        guard let touch = touches.first else {
            return
        }
        airship.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        let touchLocation = touch.location(in: self)
        let offset = touchLocation - airship.position
        airship.physicsBody?.applyImpulse(CGVector(dx: offset.x, dy: offset.y))
    }
    
    //: Helper functions for generating random floats
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addBalloons() {
        //: Call random function to determine what type of balloon to add
        let randBall = Int(arc4random_uniform(10))
        var balloon = SKSpriteNode()
        
        if randBall == 0 {
            balloon = SKSpriteNode(imageNamed: "hotAir")
            balloon.setScale(0.28)
            balloon.name = "friend"
        } else if randBall >= 1 && randBall < 3 {
            balloon = SKSpriteNode(imageNamed: "pinkBalloon")
            balloon.setScale(0.15)
            balloon.name = "pink"
        } else if randBall >= 3 && randBall < 6 {
            balloon = SKSpriteNode(imageNamed: "yellowBalloon")
            balloon.setScale(0.15)
            balloon.name = "yellow"
        } else {
            balloon = SKSpriteNode(imageNamed: "redBalloon")
            balloon.setScale(0.15)
            balloon.name = "red"
        }
        
        //: Determine where to put the balloon on the Y-axis
        let yPosition = random(min: balloon.size.height/2, max: size.height - balloon.size.height/2)
        
        //: Place balloon off-screen when it is first rendered
        balloon.position = CGPoint(x: size.width + balloon.size.width/2, y: yPosition)
        
        //: Add the balloon
        addChild(balloon)
        
        //: Determine the horizontal speed of the balloon (duration)
        let balloonSpeed = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        //: Balloon actions
            //: Move from right to left
        let balloonMove = SKAction.move(to: CGPoint(x: -balloon.size.width/2, y: yPosition), duration: TimeInterval(balloonSpeed))
            //: Remove balloon at the end of its lifecycle
        let balloonPop = SKAction.removeFromParent()
        
            //: Queue up the balloon actions and execute
        balloon.run(SKAction.sequence([balloonMove, balloonPop]))
        
        //: Give balloon a physics body to detect collisions
        balloon.physicsBody = SKPhysicsBody(rectangleOf: balloon.size)
        balloon.physicsBody?.isDynamic = false
        balloon.physicsBody?.categoryBitMask = balloonCategory
        balloon.physicsBody?.contactTestBitMask = shipCategory
    }
    
    //: Helper function for when collision is detected between ship and balloon
    func shipHitBalloon(balloon: SKSpriteNode) {
        if let ballKind = balloon.name {
            if ballKind == "friend" {
                run(SKAction.playSoundFileNamed("yay.caf", waitForCompletion: false))
                totalHighFives += 1
                totalScore += 10
            } else {
                if ballKind == "pink" {
                    totalScore += 5
                } else if ballKind == "yellow" {
                    totalScore += 3
                } else {
                    totalScore += 1
                }
                run(SKAction.playSoundFileNamed("bell.caf", waitForCompletion: false))
                totalBalloons += 1
            }
        }
        
        //: Recreate the labels
            //: 1. Remove labels
        scoreLabelNode.removeFromParent()
        balloonsLabelNode.removeFromParent()
        highFiveLabelNode.removeFromParent()
        
            //: 2. Create labels
        scoreLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabelNode.fontSize = 18.0
        scoreLabelNode.text = "Score: \(totalScore)"
        scoreLabelNode.position = CGPoint(x: scoreLabelNode.frame.maxX, y: 8)
        
        balloonsLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        balloonsLabelNode.text = "Balloons: \(totalBalloons)"
        balloonsLabelNode.fontSize = 18.0
        balloonsLabelNode.position = CGPoint(x: self.frame.midX, y: 8)
        
        highFiveLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        highFiveLabelNode.text = "High-fives: \(totalHighFives)"
        highFiveLabelNode.fontSize = 18.0
        highFiveLabelNode.position = CGPoint(x: self.frame.width - highFiveLabelNode.frame.maxX, y: 8)
        
            //: 3. Add labels
        addChild(scoreLabelNode)
        addChild(balloonsLabelNode)
        addChild(highFiveLabelNode)
        
        balloon.removeFromParent()
    }
    
    //: Contact delegate method
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if ((firstBody.categoryBitMask & shipCategory != 0) &&
            (secondBody.categoryBitMask & balloonCategory != 0)) {
            if let _ = firstBody.node as? SKSpriteNode, let
                balloon = secondBody.node as? SKSpriteNode {
                shipHitBalloon(balloon: balloon)
            }
        }
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
        
        // Check position of the airship and modify the vertical gravity vector as needed
        if Int(airship.position.y) > Int(size.height*0.55) {
            gravityVectorY.removeFromParent()
            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, -1, 0))
        } else if Int(airship.position.y) < Int(size.height*0.45) {
            gravityVectorY.removeFromParent()
            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, 1, 0))
        } else {
            gravityVectorY.removeFromParent()
            gravityVectorY = SKFieldNode.linearGravityField(withVector: vector_float3(0, 0, 0))
        }
        gravityVectorY.strength = 1.0
        addChild(gravityVectorY)
        
        // Next, move each of the layers.
        // Objects that should appear move slower than foreground objects.
        self.moveSprite(sprite: skyNode, nextSprite:skyNodeNext, speed:25.0)
        self.moveSprite(sprite: cloudsNode, nextSprite:cloudsNodeNext,
                        speed:50.0)
        self.moveSprite(sprite: groundNode, nextSprite:groundNodeNext, speed:75.0)
    }
}


