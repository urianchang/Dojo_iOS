//
//  Boss.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/12/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
class Boss: SKSpriteNode, GameSprite {
    
    var initialSize:CGSize = CGSize(width: 180, height: 220)
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"Boss")
    var flyAnimation = SKAction()
    var dieAnimation = SKAction()
    var bounceAnimation = SKAction()
    var health:Int = 3
    var invulnerable = false
    var damaged = false
    var damageAnimation = SKAction()
    
    init() {
        super.init(texture: nil, color: .clear, size:
            initialSize)
        createAnimations()
        self.run(flyAnimation)
        let bodyTexture = textureAtlas.textureNamed("Idle__000")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 500
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.bullet.rawValue | PhysicsCategory.penguin.rawValue
        self.physicsBody?.collisionBitMask = 0
        let flipnegative = SKAction.scaleX(to: -1, duration:0)
        self.run(flipnegative)
    }
    
    func createAnimations() {
        let flyFrames:[SKTexture] =
            [textureAtlas.textureNamed("Idle1__000"),
             textureAtlas.textureNamed("Idle1__001"),
             textureAtlas.textureNamed("Idle1__002"),
             textureAtlas.textureNamed("Idle1__003"),
             textureAtlas.textureNamed("Idle1__004"),
             textureAtlas.textureNamed("Idle1__005"),
             textureAtlas.textureNamed("Idle1__006"),
             textureAtlas.textureNamed("Idle1__007"),
             textureAtlas.textureNamed("Idle1__008"),
             textureAtlas.textureNamed("Idle1__009")]
        let flyAction = SKAction.animate(with: flyFrames,
                                         timePerFrame: 0.14)
        flyAnimation = SKAction.repeatForever(flyAction)
        
        
        let dieFrames:[SKTexture] = [
            textureAtlas.textureNamed("Death1__000"),
            textureAtlas.textureNamed("Death1__001"),
            textureAtlas.textureNamed("Death1__002"),
            textureAtlas.textureNamed("Death1__003"),
            textureAtlas.textureNamed("Death1__004"),
            textureAtlas.textureNamed("Death1__005"),
            textureAtlas.textureNamed("Death1__006"),
            textureAtlas.textureNamed("Death1__007"),
            textureAtlas.textureNamed("Death1__008"),
            textureAtlas.textureNamed("Death1__009")]
        dieAnimation = SKAction.animate(with: dieFrames,
                                        timePerFrame: 0.33)
        
        let downpath = SKAction.moveBy(x: 0, y: -190, duration: 1)
        let uppath = SKAction.moveBy(x: 0, y: 190, duration: 1)
        let bounceAction = SKAction.sequence([downpath, uppath])
        bounceAnimation = SKAction.repeatForever(bounceAction)
        
        let damageStart = SKAction.run {
            self.physicsBody?.categoryBitMask = PhysicsCategory.damagedPenguin.rawValue
            print ("boss is inv temp")
        }
        let slowFade = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.3, duration: 0.25),
            SKAction.fadeAlpha(to: 0.7, duration: 0.25)
            ])
        let fastFade = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.3, duration: 0.1),
            SKAction.fadeAlpha(to: 0.7, duration: 0.1)
            ])
        let fadeOutAndIn = SKAction.sequence([
            SKAction.repeat(slowFade, count: 2),
            SKAction.repeat(fastFade, count: 5),
            SKAction.fadeAlpha(to: 1, duration: 0.15)
            ])
        let damageEnd = SKAction.run {
            self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
            self.damaged = false
        }
        self.damageAnimation = SKAction.sequence([
            damageStart,
            fadeOutAndIn,
            damageEnd
            ])
    }
    
    func die() {
        self.alpha = 1
        self.removeAllActions()
        self.run(self.dieAnimation)
        if let gameScene = self.parent as? GameScene {
            gameScene.gameWin()
        }
        else if let gameScene = self.parent as? BossScene {
            gameScene.gameWin()
        }
    }
    
    func takeDamage() {
        print ("boss take dmg")
        if self.invulnerable || self.damaged { return }
        self.damaged = true
        self.health -= 1
        if self.health == 0 {
            die() }
        else {
            self.run(self.damageAnimation)
        }
    }

    
    func onTap() {}
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
