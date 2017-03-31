//
//  GrayNote.swift
//  Chorus
//
//  Created by Carolyn Yen on 3/29/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GrayNote: SKSpriteNode, GameSprite {
    
    var initialSize = CGSize(width: 100, height: 30)
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"MusicNote")
    var status = false
    
    
    init() {
        super.init(texture: textureAtlas.textureNamed("Block_gray"), color: .clear, size: initialSize)
         self.name = "music_note"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func onTap(){
        if status == false {
            status = true
            self.texture = textureAtlas.textureNamed("Block_colored")
            let bodyTexture = textureAtlas.textureNamed("Block_colored")
            self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
            self.physicsBody?.isDynamic = false
            self.physicsBody?.friction = 0
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.categoryBitMask = PhysicsCategory.note.rawValue
        }
        else {
            status = false
            self.texture = textureAtlas.textureNamed("Block")
            self.physicsBody = nil
        }
    }
    
}
