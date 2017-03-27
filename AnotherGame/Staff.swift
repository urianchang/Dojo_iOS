//
//  Staff.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
class Staff: SKSpriteNode, GameSprite {
        let coinSound =
        SKAction.playSoundFileNamed("Sound/Coin.aif",
                                    waitForCompletion: false)
        var initialSize:CGSize = CGSize(width: 28, height: 24)
        var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"Staff")
        var flyAnimation = SKAction()
        var bounceAnimation = SKAction()
        var value = 1
    
        init() {
            super.init(texture: nil, color: .clear, size:
                initialSize)
            self.texture = textureAtlas.textureNamed("staff1")
            createAnimations()
            self.run(bounceAnimation)
            self.physicsBody = SKPhysicsBody(circleOfRadius:
                size.width / 2)
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
            self.physicsBody?.collisionBitMask = 0
        }
    
        func createAnimations() {
            let downpath = SKAction.moveBy(x: 0, y: -190, duration: 1)
            let uppath = SKAction.moveBy(x: 0, y: 190, duration: 1)
            let bounceAction = SKAction.sequence([downpath, uppath])
            bounceAnimation = SKAction.repeatForever(bounceAction)
        }
    
        func collect() {
            self.physicsBody?.categoryBitMask = 0
            let collectAnimation = SKAction.group([
                SKAction.fadeAlpha(to: 0, duration: 0.2),
                SKAction.scale(to: 1.5, duration: 0.2),
                SKAction.move(by: CGVector(dx: 0, dy: 25),
                              duration: 0.2)
                ])
            let resetAfterCollected = SKAction.run {
                self.position.y = 5000
                self.alpha = 1
                self.xScale = 1
                self.yScale = 1
                self.physicsBody?.categoryBitMask =
                    PhysicsCategory.coin.rawValue
            }
            let collectSequence = SKAction.sequence([
                collectAnimation,
                resetAfterCollected
                ])
            self.run(collectSequence)
            self.run(coinSound)
    }
    
    
    
        func onTap() {}
        required init? (coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
}

