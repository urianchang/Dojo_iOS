//
//  Bee.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
class Bee: SKSpriteNode, GameSprite {
    var initialSize:CGSize = CGSize(width: 28, height: 24)
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"Enemies")
    var flyAnimation = SKAction()
    var bounceAnimation = SKAction()
    init() {
        super.init(texture: nil, color: .clear, size:
            initialSize)
        createAnimations()
        self.run(flyAnimation)
        self.run(bounceAnimation)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 50
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy.rawValue
        self.physicsBody?.contactTestBitMask = PhysicsCategory.penguin.rawValue
        self.physicsBody?.collisionBitMask = 0
}
    func createAnimations() {
        let flyFrames:[SKTexture] =
            [textureAtlas.textureNamed("bee"),
             textureAtlas.textureNamed("bee-fly")]
        let flyAction = SKAction.animate(with: flyFrames,
                                         timePerFrame: 0.14)
        flyAnimation = SKAction.repeatForever(flyAction)
        
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
