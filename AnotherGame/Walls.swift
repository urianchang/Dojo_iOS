//
//  Walls.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/14/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit

class Wall: SKSpriteNode, GameSprite {
    var textureAtlas:SKTextureAtlas =
        SKTextureAtlas(named: "Environment")
    var initialSize = CGSize.zero
    
    func createChildren(topleft: CGPoint, topright: CGPoint, position: CGPoint) {
        self.anchorPoint = position
        let pointTopLeft = topleft
        let pointTopRight = topright
        self.physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft,
                                         to: pointTopRight)
        self.physicsBody?.friction = 0.9
        self.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
    }

    func onTap() {}
}

//class Wall: SKSpriteNode, GameSprite {
//    
//    var initialSize:CGSize = CGSize(width: 120, height: 100)
//    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"Tree")
//    
//    init() {
//        super.init(texture: textureAtlas.textureNamed("rock"), color: .clear, size: initialSize)
//        let bodyTexture = textureAtlas.textureNamed("rock")
//        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
//        self.physicsBody?.affectedByGravity = true
//        self.physicsBody?.isDynamic = false
//        self.physicsBody?.allowsRotation = false
//        self.physicsBody?.mass = 500
//        
//        self.physicsBody?.categoryBitMask = PhysicsCategory.rock.rawValue
//    }
//    
//    
//    func onTap() {}
//    
//    required init? (coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//}
