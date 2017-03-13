//
//  scene1.swift
//  gameTest1
//
//  Created by Urian Chang on 3/13/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import SpriteKit

class scene1: SKScene {
    
    private var label : SKLabelNode?
    
    override func didMove(to view: SKView) {
        print ("scene1 loaded")
        self.label = self.childNode(withName: "//testLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
    }
    override func update(_ currentTime: TimeInterval) {
    }
    
}
