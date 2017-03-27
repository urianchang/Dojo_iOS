//
//  Tree.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit

class Tree: SKSpriteNode, GameSprite {
    
    var initialSize:CGSize = CGSize(width: 130, height: 240)
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"Tree")
    
    init() {
        super.init(texture: textureAtlas.textureNamed("tree"), color: .clear, size: initialSize)
        let bodyTexture = textureAtlas.textureNamed("tree")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 500
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.tree.rawValue
    }
    
    
    func onTap() {}
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
