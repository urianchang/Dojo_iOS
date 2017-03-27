//
//  HUD.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit

class HUD: SKNode {
    var textureAtlas = SKTextureAtlas(named:"HUD")
    var coinAtlas = SKTextureAtlas(named: "Staff")
    var heartNodes:[SKSpriteNode] = []
    let coinCountText = SKLabelNode(text: "0/3")
    let restartButton = SKSpriteNode()
    let menuButton = SKSpriteNode()
    let menuText = SKLabelNode(fontNamed: "Papyrus")
    let restartText = SKLabelNode(fontNamed: "Papyrus")
    let overText = SKLabelNode(fontNamed: "Papyrus")
    var backgroundImage = SKSpriteNode(imageNamed:"gameover")
    let playerText = SKLabelNode(fontNamed: "Papyrus")
    let playerText2 = SKLabelNode(fontNamed: "Papyrus")
    let blood = Blood()
    
    let textureAtlas2:SKTextureAtlas = SKTextureAtlas(named:"Arrows")
    let GravityButtonU = SKSpriteNode()
    let GravityButtonL = SKSpriteNode()
    let GravityButtonR = SKSpriteNode()
    let GravityButtonD = SKSpriteNode()
    let GunButton = SKSpriteNode()
    let startText = SKLabelNode(fontNamed:
        "Papyrus")
    
    
    func createHudNodes(screenSize:CGSize) {
        
//        print("The width of the screen is \(screenSize.width)")
        
        let cameraOrigin = CGPoint(
            x: screenSize.width / 2,
            y: screenSize.height / 2)
        let coinIcon = SKSpriteNode(texture:
            coinAtlas.textureNamed("staff"))
        let coinPosition = CGPoint(x:
            -cameraOrigin.x + 23, y: cameraOrigin.y - 23)
        coinIcon.size = CGSize(width: 26, height: 26)
        coinIcon.position = coinPosition
        coinCountText.fontName = "AvenirNext-HeavyItalic"
        let coinTextPosition = CGPoint(x:
            -cameraOrigin.x + 41, y: coinPosition.y)
        coinCountText.position = coinTextPosition
        coinCountText.horizontalAlignmentMode =
            SKLabelHorizontalAlignmentMode.left
        coinCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.addChild(coinCountText)
        self.addChild(coinIcon)
        for index in 0 ..< 3 {
            let newHeartNode = SKSpriteNode(texture: textureAtlas.textureNamed("heart-full"))
            newHeartNode.size = CGSize (width: 26, height: 26)
            let xPos = -cameraOrigin.x + CGFloat(index * 28) + 33
            let yPos = cameraOrigin.y - 66
            newHeartNode.position = CGPoint(x: xPos, y: yPos)
            heartNodes.append(newHeartNode)
            self.addChild(newHeartNode)
        }
        
        GravityButtonU.texture = textureAtlas2.textureNamed("up")
        GravityButtonU.size = CGSize(width: 40, height: 40)
        GravityButtonU.name = "Up"
        GravityButtonU.position = CGPoint(x: (screenSize.width / 2) - 60 , y: (screenSize.height / 2) - 30 )
        
        GravityButtonL.texture = textureAtlas2.textureNamed("left")
        GravityButtonL.size = CGSize(width: 40, height: 40)
        GravityButtonL.name = "Left"
        GravityButtonL.position = CGPoint(x: (screenSize.width / 2) - 90 , y: (screenSize.height / 2) - 60 )
        
        GravityButtonR.texture = textureAtlas2.textureNamed("right")
        GravityButtonR.size = CGSize(width: 40, height: 40)
        GravityButtonR.name = "Right"
        GravityButtonR.position = CGPoint(x: (screenSize.width / 2) - 30 , y: (screenSize.height / 2) - 60 )
        
        GravityButtonD.texture = textureAtlas2.textureNamed("down")
        GravityButtonD.size = CGSize(width: 40, height: 40)
        GravityButtonD.name = "Down"
        GravityButtonD.position = CGPoint(x: (screenSize.width / 2) - 60 , y: (screenSize.height / 2) - 90 )
        
        GunButton.texture = SKTextureAtlas(named:"RedHood").textureNamed("ball")
        GunButton.size = CGSize(width: 40, height: 40)
        GunButton.name = "Gun"
        GunButton.position = CGPoint(x: -(screenSize.width/2) + 50 , y: (screenSize.height / 2) - 105)
        
        startText.text = "Off"
        startText.fontColor = SKColor.blue
        startText.verticalAlignmentMode = .center
        startText.position = CGPoint(x: 0, y: 2)
        startText.fontSize = 18
        
        startText.name = "Gun"
        startText.zPosition = 5
        GunButton.addChild(startText)
        
        restartButton.texture =
            textureAtlas.textureNamed("button-restart")
        menuButton.texture =
            textureAtlas.textureNamed("button-menu")
        restartButton.name = "restartGame"
        menuButton.name = "returnToMenu"
        menuButton.position = CGPoint(x: -140, y: 0)
        restartButton.size = CGSize(width: 140, height: 140)
        menuButton.size = CGSize(width: 70, height: 70)
        
        menuText.text = "Menu"
        menuText.position = CGPoint(x: -140, y: -65)
        menuText.fontSize = 28
        menuText.fontColor = SKColor.red
        
        restartText.text = "Restart"
        restartText.position = CGPoint(x: 0, y: -100)
        restartText.fontSize = 28
        restartText.fontColor = SKColor.red
        
        overText.text = "Game Over"
        overText.position = CGPoint(x: -5, y: 140)
        overText.fontSize = 70
        overText.fontColor = SKColor.red
        
        playerText.text = "hi"
        playerText.position = CGPoint(x: 0, y: screenSize.height/2 - (playerText.frame.maxY-2))
        playerText.fontSize = 28
        playerText.fontColor = SKColor.red
        
        playerText2.text = "hi2"
        playerText2.position = CGPoint(x: -5, y: 130)
        playerText2.fontSize = 28
        playerText2.fontColor = SKColor.red
        
        backgroundImage.size = CGSize(width: 1024, height: 420)
        backgroundImage.zPosition = -1
        
        blood.position = CGPoint(x: 250, y: 180)
    }
    
    func showButtons() {
        restartButton.alpha = 0
        menuButton.alpha = 0
        menuText.alpha = 0
        restartText.alpha = 0
        backgroundImage.alpha = 0
        overText.alpha = 0
        blood.alpha = 0
        self.addChild(restartButton)
        self.addChild(menuButton)
        self.addChild(menuText)
        self.addChild(restartText)
        self.addChild(overText)
        self.addChild(backgroundImage)
        self.addChild(blood)
        let fadeAnimation = SKAction.fadeAlpha(to: 1, duration: 0.4)
        let fadeAnimation2 = SKAction.fadeAlpha(to: 1, duration: 2)
        let fadeAnimation3 = SKAction.fadeAlpha(to: 1, duration: 3)
        restartButton.run(fadeAnimation)
        menuButton.run(fadeAnimation)
        menuText.run(fadeAnimation)
        restartText.run(fadeAnimation)
        overText.run(fadeAnimation)
        backgroundImage.run(fadeAnimation2)
        blood.run(fadeAnimation3)
    }
    
    func showWin(){
        menuButton.alpha = 0
        menuText.alpha = 0
        restartText.alpha = 0
        backgroundImage = SKSpriteNode(imageNamed:"win")
        overText.fontSize = 40
        overText.text = "YOU WIN THE GAME!"
        overText.alpha = 0
        startText.alpha = 0
        GunButton.alpha = 0
        restartButton.alpha = 0
        backgroundImage.alpha = 0
        self.addChild(overText)
        self.addChild(backgroundImage)
        self.addChild(restartButton)
        let fadeAnimation2 = SKAction.fadeAlpha(to: 1, duration: 4)
        let fadeAnimation3 = SKAction.fadeAlpha(to: 1, duration: 7)
        backgroundImage.run(fadeAnimation2)
        restartButton.run(fadeAnimation3)
        overText.run(fadeAnimation3)
    }
    
    func showLabel(changetext: String, changetext2: String, color: SKColor, size: CGFloat) {
        playerText.removeFromParent()
        playerText.alpha = 0
        playerText.text = changetext
        playerText.fontColor = color
        playerText.fontSize = size
        playerText2.removeFromParent()
        playerText2.alpha = 0
        playerText2.text = changetext2
        playerText2.fontColor = color
        playerText2.fontSize = size
        self.addChild(playerText)
        self.addChild(playerText2)
        let fadeAnimation = SKAction.fadeAlpha(to: 1, duration: 2)
        playerText.run(fadeAnimation)
        playerText2.run(fadeAnimation)
    }
    
    func fadeLabel() {
        let fadeoutAnimation = SKAction.fadeAlpha(to: 0, duration: 2)
        playerText.run(fadeoutAnimation)
        playerText2.run(fadeoutAnimation)
    }
    
    func changeGun(text: String, color: SKColor) {
       startText.text = text
       startText.fontColor = color
    }
    
    func setCoinCountDisplay(newCoinCount:Int) {
        let formatter = NumberFormatter()
        let number = NSNumber(value: newCoinCount)
        formatter.minimumIntegerDigits = 1
        if let coinStr =
            formatter.string(from: number) {
            coinCountText.text = coinStr + "/3"
        }
    }
    
    func addGravity() {
        self.addChild(GravityButtonU)
        self.addChild(GravityButtonL)
        self.addChild(GravityButtonR)
        self.addChild(GravityButtonD)
        self.addChild(GunButton)
    }
    
    
    func setHealthDisplay(newHealth:Int) {
        let fadeAction = SKAction.fadeAlpha(to: 0.2, duration: 0.3)
        for index in 0 ..< heartNodes.count {
            if index < newHealth {
                heartNodes[index].alpha = 1
            }
            else {
                heartNodes[index].run(fadeAction)
            }
        }
    }
                    
}
