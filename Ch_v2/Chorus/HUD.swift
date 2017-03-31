//
//  HUD.swift
//  Chorus
//
//  Created by Carolyn Yen on 3/29/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class HUD: SKNode {
    
    var StartButton = SKSpriteNode()
    var CancelButton = SKSpriteNode()
    var RestartButton = SKSpriteNode()
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"PlayButtons")
    var status = true
    
    
    func createHudNodes(screenSize:CGSize) {
        let cameraOrigin = CGPoint(
            x: screenSize.width / 2,
            y: screenSize.height / 2)

        StartButton = SKSpriteNode(texture: textureAtlas.textureNamed("start"), color: .clear, size: CGSize(width: 35, height: 35))
        let coinPosition = CGPoint(x: -cameraOrigin.x + 60, y: cameraOrigin.y - 23)
        StartButton.position = coinPosition
        StartButton.alpha = 1
        StartButton.name = "start"
        self.addChild(StartButton)
        
        RestartButton = SKSpriteNode(texture: textureAtlas.textureNamed("restart"), color: .clear, size: CGSize(width: 35, height: 35))
        let coinPosition2 = CGPoint(x: -cameraOrigin.x + 23, y: cameraOrigin.y - 23)
        RestartButton.position = coinPosition2
        RestartButton.alpha = 1
        RestartButton.name = "restart"
        self.addChild(RestartButton)
    }
    
    func changebutton() {
        if status == false {
            StartButton.texture = textureAtlas.textureNamed("start")
            status = true
        }
        else {
            StartButton.texture = textureAtlas.textureNamed("pause")
            status = false
        }
        
    }
}
