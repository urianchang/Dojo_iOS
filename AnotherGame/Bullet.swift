//
//  Bullet.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/12/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
class Bullet: SKSpriteNode, GameSprite {
    var initialSize:CGSize = CGSize(width: 30, height: 30)
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"RedHood")
    var flyAnimation = SKAction()
    var bounceAnimation = SKAction()
    init() {
        super.init(texture: textureAtlas.textureNamed("bullet"), color: .clear, size: initialSize)
        createAnimations()
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 5
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.bullet.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.enemy.rawValue
//        self.physicsBody?.contactTestBitMask = ~PhysicsCategory.damagedPenguin.rawValue | ~PhysicsCategory.penguin.rawValue
        self.physicsBody?.collisionBitMask = 0
    }
    func createAnimations() {
        let downpath = SKAction.moveBy(x: 0, y: -190, duration: 1)
        let uppath = SKAction.moveBy(x: 0, y: 190, duration: 1)
        let bounceAction = SKAction.sequence([downpath, uppath])
        bounceAnimation = SKAction.repeatForever(bounceAction)
    }
    func onTap() {}
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
