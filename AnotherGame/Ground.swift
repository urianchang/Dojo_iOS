//
//  Ground.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
class Ground: SKSpriteNode, GameSprite {
    var jumpWidth = CGFloat()
    var jumpCount = CGFloat(1)
    var textureAtlas:SKTextureAtlas =
        SKTextureAtlas(named: "Environment")
    var initialSize = CGSize.zero
    
    func createChildren() {
        self.anchorPoint = CGPoint(x: 0, y: 1)
        let texture = textureAtlas.textureNamed("grass")
        var tileCount:CGFloat = 0
        let tileSize = CGSize(width: 80, height: 170)
        while tileCount * tileSize.width < self.size.width {
            let tileNode = SKSpriteNode(texture: texture)
            tileNode.size = tileSize
            tileNode.position.x = tileCount * tileSize.width
            tileNode.anchorPoint = CGPoint(x: 0, y: 1)
            self.addChild(tileNode)
            tileCount += 1
        }
        let pointTopLeft = CGPoint(x: 0, y: -2)
        let pointTopRight = CGPoint(x: size.width, y: -2)
        self.physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft,
                                         to: pointTopRight)
        self.physicsBody?.friction = 0.9
        jumpWidth = tileSize.width * floor(tileCount / 3)
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
    }
    
    func checkForReposition(playerProgress:CGFloat) {
        let groundJumpPosition = jumpWidth * jumpCount
        if playerProgress >= groundJumpPosition {
            self.position.x += jumpWidth
            jumpCount += 1
        } }
    
    func onTap() {}
}
