//
//  Powerstar.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit

class Star: SKSpriteNode, GameSprite {
    var initialSize = CGSize(width: 60, height: 60)
    var textureAtlas:SKTextureAtlas =
        SKTextureAtlas(named: "Powerstar")
    var pulseAnimation = SKAction()
    var flyAnimation = SKAction()
    init() {
        super.init(texture: nil, color: .clear,
                   size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        createAnimations()
        self.run(flyAnimation)
        self.physicsBody?.categoryBitMask = PhysicsCategory.powerup.rawValue
        self.physicsBody?.collisionBitMask = 0
    }
        func createAnimations() {
            
            let flyFrames:[SKTexture] =
                [textureAtlas.textureNamed("1"),
                 textureAtlas.textureNamed("2"),
                 textureAtlas.textureNamed("3"),
                 textureAtlas.textureNamed("4"),
                 textureAtlas.textureNamed("5"),
                 textureAtlas.textureNamed("6"),
                 textureAtlas.textureNamed("7"),
                 textureAtlas.textureNamed("8"),
                 textureAtlas.textureNamed("9"),
                 textureAtlas.textureNamed("10"),
                 textureAtlas.textureNamed("11"),
                 textureAtlas.textureNamed("12"),
                 textureAtlas.textureNamed("13"),
                 textureAtlas.textureNamed("14")]
            let flyAction = SKAction.animate(with: flyFrames,
                                             timePerFrame: 0.5)
            flyAnimation = SKAction.repeatForever(flyAction)
            
            // Scale the star smaller and fade it slightly:
            let pulseOutGroup = SKAction.group([
                SKAction.fadeAlpha(to: 0.85, duration: 0.8),
                SKAction.scale(to: 0.6, duration: 0.8),
                SKAction.rotate(byAngle: -0.3, duration: 0.8)
                ])
            // Push the star big again, and fade it back in:
            let pulseInGroup = SKAction.group([
                SKAction.fadeAlpha(to: 1, duration: 1.5),
                SKAction.scale(to: 1, duration: 1.5),
                SKAction.rotate(byAngle: 3.5, duration: 1.5)
                ])
            // Combine the two into a sequence:
            let pulseSequence = SKAction.sequence([pulseOutGroup,
                                                   pulseInGroup])
            pulseAnimation =
                SKAction.repeatForever(pulseSequence)
        }
        func onTap() {}
        required init? (coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
}
