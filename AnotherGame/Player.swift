//
//  Player.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
class Player : SKSpriteNode, GameSprite {
    let hurtSound =
        SKAction.playSoundFileNamed("Sound/ouch.aif",
                                    waitForCompletion: false)
    var initialSize = CGSize(width: 100, height: 100)
    var textureAtlas:SKTextureAtlas =
        SKTextureAtlas(named:"RedHood")
    var flyAnimation = SKAction()
    var soarAnimation = SKAction()
    var fightAnimation = SKAction()
    var fightAnimation2 = SKAction()
    var flapping = false
    let maxFlappingForce:CGFloat = 35000
    let maxHeight:CGFloat = 1000
    
    
    var health:Int = 3
    var invulnerable = false
    var damaged = false
    var damageAnimation = SKAction()
    var dieAnimation = SKAction()
    var attackright = SKAction()
    var forwardVelocity:CGFloat = 200
    
    init() {
        
        super.init(texture: nil, color: .clear, size:
            initialSize)
        createAnimations()
        
        self.run(soarAnimation, withKey: "soarAnimation")
        let bodyTexture = textureAtlas.textureNamed("Idle_000")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.linearDamping = 0.9
        self.physicsBody?.mass = 40
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.penguin.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemy.rawValue | PhysicsCategory.powerup.rawValue | PhysicsCategory.coin.rawValue | PhysicsCategory.tree.rawValue | PhysicsCategory.rock.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.ground.rawValue | PhysicsCategory.tree.rawValue | PhysicsCategory.rock.rawValue

    }
    
    func createAnimations() {
        let flyFrames:[SKTexture] = [
            textureAtlas.textureNamed("Walk_000"),
            textureAtlas.textureNamed("Walk_001"),
            textureAtlas.textureNamed("Walk_002"),
            textureAtlas.textureNamed("Walk_003"),
            textureAtlas.textureNamed("Walk_004")]
        let flyAction = SKAction.animate(with: flyFrames,
                                         timePerFrame: 0.23)
        flyAnimation = SKAction.group([
            SKAction.repeatForever(flyAction)
            ])
        
        let soarFrames:[SKTexture] = [
                textureAtlas.textureNamed("Idle_000"),
                textureAtlas.textureNamed("Idle_001"),
                textureAtlas.textureNamed("Idle_002"),
                textureAtlas.textureNamed("Idle_003"),
                textureAtlas.textureNamed("Idle_004")]
        let soarAction = SKAction.animate(with: soarFrames,
                                          timePerFrame: 0.23)
        soarAnimation = SKAction.group([
            SKAction.repeatForever(soarAction)
            ])
        
        let fightFrames:[SKTexture] = [
            textureAtlas.textureNamed("Attack 1_000"),
            textureAtlas.textureNamed("Attack 1_001"),
            textureAtlas.textureNamed("Attack 1_002"),
            textureAtlas.textureNamed("Attack 1_003"),
            textureAtlas.textureNamed("Attack 1_004")]
        let fightAction = SKAction.animate(with: fightFrames,
                                          timePerFrame: 0.23)
        fightAnimation = SKAction.group([
            SKAction.repeatForever(fightAction)
            ])
        
        let fightFrames2:[SKTexture] = [
            textureAtlas.textureNamed("Attack 2_000"),
            textureAtlas.textureNamed("Attack 2_001"),
            textureAtlas.textureNamed("Attack 2_002"),
            textureAtlas.textureNamed("Attack 2_003"),
            textureAtlas.textureNamed("Attack 2_004")]
        let fightAction2 = SKAction.animate(with: fightFrames2,
                                           timePerFrame: 0.23)
        fightAnimation2 = SKAction.group([
            SKAction.repeatForever(fightAction2)
            ])
        
        let dieFrames:[SKTexture] = [
            textureAtlas.textureNamed("Die_000"),
            textureAtlas.textureNamed("Die_001"),
            textureAtlas.textureNamed("Die_002"),
            textureAtlas.textureNamed("Die_003"),
            textureAtlas.textureNamed("Die_004")]
        dieAnimation = SKAction.animate(with: dieFrames,
                                            timePerFrame: 0.23)
        
        let attackrightFrames:[SKTexture] = [
            textureAtlas.textureNamed("Attack 1_000"),
            textureAtlas.textureNamed("Attack 1_001"),
            textureAtlas.textureNamed("Attack 1_002"),
            textureAtlas.textureNamed("Attack 1_003"),
            textureAtlas.textureNamed("Attack 1_004")]
        attackright = SKAction.animate(with: attackrightFrames,
                                        timePerFrame: 0.33)
        
        let damageFrames:[SKTexture] = [
            textureAtlas.textureNamed("Hurt_000"),
            textureAtlas.textureNamed("Hurt_001"),
            textureAtlas.textureNamed("Hurt_002"),
            textureAtlas.textureNamed("Hurt_003"),
            textureAtlas.textureNamed("Hurt_004")]
        let damageAction = SKAction.animate(with: damageFrames,
                                         timePerFrame: 0.23)
        damageAnimation = SKAction.group([
            SKAction.repeatForever(damageAction)
            ])
        
        // --- Create the taking damage animation ---
        let damageStart = SKAction.run {
            // Allow the penguin to pass through enemies:
            self.physicsBody?.categoryBitMask = PhysicsCategory.damagedPenguin.rawValue
        }
        // Create an opacity pulse, slow at first and fast at the end:
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
        // Return the penguin to normal:
        let damageEnd = SKAction.run {
            self.physicsBody?.categoryBitMask =
                PhysicsCategory.penguin.rawValue
            // Turn off the newly damaged flag:
            self.damaged = false
        }
        // Store the whole sequence in the damageAnimation property:
        self.damageAnimation = SKAction.sequence([
            damageStart,
            fadeOutAndIn,
            damageEnd
            ])
    }
    
    func startFlapping() {
        if self.health <= 0 { return }
        self.removeAction(forKey: "soarAnimation")
        self.run(flyAnimation, withKey: "flapAnimation")
        self.flapping = true
    }
    
    func attackRight() {
        self.removeAllActions()
        self.run(self.attackright)
        self.flapping = false
        self.forwardVelocity = 0
        if self.health <= 0 { return }
        print("attack")
    }
    
    func attackLeft() {
        self.alpha = 1
        self.removeAllActions()
        let flipnegative = SKAction.scaleX(to: -1, duration:0)
        self.run(flipnegative)
        self.run(self.attackright)
        self.flapping = false
        self.forwardVelocity = 0
        if self.health <= 0 { return }
        print("attack2")
    }
    
    func die() {
        self.alpha = 1
        self.removeAllActions()
        self.run(self.dieAnimation)
        self.flapping = false
        self.forwardVelocity = 0
        print("shes dead")
        if let gameScene = self.parent as? GameScene {
            gameScene.gameOver()
        }
        else if let gameScene = self.parent as? BossScene {
            gameScene.gameOver()
        }
    }
    
    func takeDamage() {
        if self.invulnerable || self.damaged { return }
        self.damaged = true
        self.health -= 1
        print(self.health)
        if self.health == 0 {
            die() }
        else {
            self.run(self.damageAnimation)
        }
        self.run(hurtSound)
    }
    
    func stopFlapping() {
        if self.health <= 0 { return }
        self.removeAction(forKey: "flapAnimation")
        self.run(soarAnimation, withKey: "soarAnimation")
        self.flapping = false
    }
    
    
    func turnup() {
        let flipnegative = SKAction.rotate(byAngle: CGFloat.pi, duration:1)
        self.run(flipnegative)
    }
    
    func turnleft() {
        let flipnegative = SKAction.rotate(byAngle: -CGFloat.pi/2, duration:1)
        self.run(flipnegative)
    }
    
    
    
    func turnback() {
        let flipnegative = SKAction.scaleX(to: -1, duration:0)
        self.run(flipnegative)
    }
    func turnback2() {
        let flipnegative = SKAction.scaleX(to: 1, duration:0)
        self.run(flipnegative)
    }
    
    func turnfront(){
        let flippositive = SKAction.scaleX(to: 1, duration:0)
        self.run(flippositive)
    }
    func turnfront2(){
        let flippositive = SKAction.scaleX(to: -1, duration:0)
        self.run(flippositive)
    }
    
    
    
    
    
    
    func onTap() {
    }
    
    func update() {
    }

    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
