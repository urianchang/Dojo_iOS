//
//  Blood.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/12/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit

class Blood: SKSpriteNode, GameSprite {
    var initialSize:CGSize = CGSize(width: 150, height: 100)
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"Blood")
    var dieAnimation = SKAction()
    
    init() {
        super.init(texture: nil, color: .clear, size:
            initialSize)
        createAnimations()
        self.run(dieAnimation)
    }
    
    func createAnimations() {
        let dieFrames:[SKTexture] = [
            textureAtlas.textureNamed("blood_3_1"),
            textureAtlas.textureNamed("blood_3_2"),
            textureAtlas.textureNamed("blood_3_3"),
            textureAtlas.textureNamed("blood_3_4")]
        dieAnimation = SKAction.animate(with: dieFrames,
                                        timePerFrame: 0.53)
    }
    
    func onTap() {}
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
