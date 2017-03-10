//
//  GameOverScene.swift
//  SpriteKitSimpleGame
//
//  Created by Urian Chang on 3/10/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, won:Bool) {
        
        super.init(size: size)
        
        // 1 Sets background color to white
        backgroundColor = SKColor.white
        
        // 2 Based on won parameter, displays appropriate message
        let message = won ? "You Won!" : "You Lose :["
        
        // 3 Display a label of text to the screen with SpriteKit
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        // 4 Sets up and runs sequence of two actions
        run(SKAction.sequence([
            SKAction.wait(forDuration: 3.0),
            SKAction.run() {
                // 5 Transition to new scene in SpriteKit (e.g. flip transition)
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
        
    }
    
    // 6 If you override an initializer on a scene, you must implement the required init(coder:) initializer as well. However this initializer will never be called, so you just add a dummy implementation with a fatalError(_:) for now.
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
