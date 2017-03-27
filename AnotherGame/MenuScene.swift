//
//  MenuScene.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation
class MenuScene: SKScene {
    
    var musicPlayer = AVAudioPlayer()
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"HUD")
    let startButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.scaleMode = SKSceneScaleMode.resizeFill
        
        if let musicPath = Bundle.main.path(forResource:
            "Sound/BackgroundMusic.m4a", ofType: nil) {
            let url = URL(fileURLWithPath: musicPath)
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer.numberOfLoops = -1
                musicPlayer.prepareToPlay()
                musicPlayer.play()
            }
            catch { /* Couldn't load music file */ }
        }
        
        // Position nodes from the center of the scene:
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Add the background image:
        let backgroundImage = SKSpriteNode(imageNamed:"menu")
        backgroundImage.size = CGSize(width: 1024, height: 420)
        backgroundImage.zPosition = -1
        self.addChild(backgroundImage)
        
        // Draw the name of the game:
        let logoText = SKLabelNode(fontNamed: "Papyrus")
        logoText.text = "MonSwift-o"
        logoText.position = CGPoint(x: 0, y: 100)
        logoText.fontSize = 60
        logoText.fontColor = SKColor.red
        self.addChild(logoText)
        
        // Add another line below:
        let logoTextBottom = SKLabelNode(fontNamed:
            "Papyrus")
        logoTextBottom.text = "Revenge of the Plants"
        logoTextBottom.position = CGPoint(x: 0, y: 50)
        logoTextBottom.fontSize = 50
        logoTextBottom.fontColor = SKColor.red
        self.addChild(logoTextBottom)
        
        // Build the start game button:
        startButton.texture = textureAtlas.textureNamed("button")
        startButton.size = CGSize(width: 295, height: 76)
        
        // Name the start node for touch detection:
        startButton.name = "StartBtn"
        startButton.position = CGPoint(x: 0, y: -30)
        self.addChild(startButton)
        // Add text to the start button:
        let startText = SKLabelNode(fontNamed:
            "Papyrus")
        startText.text = "START GAME"
        startText.fontColor = SKColor.red
        startText.verticalAlignmentMode = .center
        startText.position = CGPoint(x: 0, y: 2)
        startText.fontSize = 40
        
        // Name the text node for touch detection:
        startText.name = "StartBtn"
        startText.zPosition = 5
        startButton.addChild(startText)
        
        // Pulse the start text in and out gently:
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.5, duration: 0.9),
            SKAction.fadeAlpha(to: 1, duration: 0.9),
            ])
        startText.run(SKAction.repeatForever(pulseAction))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // Find the location of the touch:
            let location = touch.location(in: self)
            // Locate the node at this location:
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "StartBtn" {
                // Player touched the start text or button node
                // Switch to an instance of the GameScene:
                let scene = GameScene(size: (self.view?.bounds.size)!)
                scene.scaleMode = SKSceneScaleMode.resizeFill
                self.view?.presentScene(scene)
            }
        }
    }
}

