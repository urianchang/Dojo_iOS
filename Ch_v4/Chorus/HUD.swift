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
    var Instrument = SKSpriteNode()
    var SaveButton = SKSpriteNode()
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"PlayButtons")
    var status = true
    var Piano = SKSpriteNode()
    var Violin = SKSpriteNode()
    var Broom = SKSpriteNode()
    var Tempo = SKLabelNode(text: "Tempo: 100")
    
    var C3Note = SKSpriteNode()
    var CSNote = SKSpriteNode()
    var DNote =  SKSpriteNode()
    var DSNote = SKSpriteNode()
    var ENote =  SKSpriteNode()
    var FNote =  SKSpriteNode()
    var FSNote = SKSpriteNode()
    var GNote =  SKSpriteNode()
    var GSNote = SKSpriteNode()
    var ANote =  SKSpriteNode()
    var ASNote = SKSpriteNode()
    var BNote =  SKSpriteNode()
    var C4Note = SKSpriteNode()
    var textureAtlas2: SKTextureAtlas = SKTextureAtlas(named:"PianoKeys")
    
    
    func createHudNodes(screenSize:CGSize) {
        let cameraOrigin = CGPoint(
            x: screenSize.width / 2,
            y: screenSize.height/2)
        
        Instrument = SKSpriteNode(texture: textureAtlas.textureNamed("piano"), color: .clear, size: CGSize(width: 40, height: 40))
        let instPosition = CGPoint(x: -cameraOrigin.x/2 - 30, y: cameraOrigin.y - 23)
        Instrument.position = instPosition
        Instrument.alpha = 1
        Instrument.name = "change"
        self.addChild(Instrument)
        
        SaveButton = SKSpriteNode(texture: textureAtlas.textureNamed("save"), color: .clear, size: CGSize(width: 35, height: 35))
        let savePosition = CGPoint(x: cameraOrigin.x - 40, y: cameraOrigin.y - 23)
        SaveButton.position = savePosition
        SaveButton.alpha = 1
        SaveButton.name = "save"
        self.addChild(SaveButton)
        
        Broom = SKSpriteNode(texture: textureAtlas.textureNamed("clear"), color: .clear, size: CGSize(width: 35, height: 35))
        let clearPosition = CGPoint(x: cameraOrigin.x - 100, y: cameraOrigin.y - 23)
        Broom.position = clearPosition
        Broom.alpha = 1
        Broom.name = "clear"
        self.addChild(Broom)
        
        Tempo.fontColor = SKColor.blue
        Tempo.verticalAlignmentMode = .center
        Tempo.position = CGPoint(x: cameraOrigin.x - 420, y: cameraOrigin.y - 23)
        Tempo.fontSize = 18
        self.addChild(Tempo)
        

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
        
        Piano = SKSpriteNode(texture: textureAtlas.textureNamed("piano"), color: .clear, size: CGSize(width: 200, height: 200))
        Violin = SKSpriteNode(texture: textureAtlas.textureNamed("guitar"), color: .clear, size: CGSize(width: 200, height: 200))
        Piano.name = "piano"
        Violin.name = "violin"
        let pianoPosition = CGPoint(x: -cameraOrigin.x/2 + 50, y: cameraOrigin.y - 200)
        Piano.position = pianoPosition
        let violinPosition = CGPoint(x: -cameraOrigin.x/2 + 240, y: cameraOrigin.y - 200)
        Violin.position = violinPosition
        
        
        //notes
        C3Note = SKSpriteNode(texture: textureAtlas2.textureNamed("white"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition3 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 400)
        C3Note.position = coinPosition3
        C3Note.alpha = 1
        C3Note.name = "pC3"
        self.addChild(C3Note)
        
        CSNote = SKSpriteNode(texture: textureAtlas2.textureNamed("black"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition4 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 372)
        CSNote.position = coinPosition4
        CSNote.alpha = 1
        CSNote.name = "pCS"
        self.addChild(CSNote)
        
        DNote = SKSpriteNode(texture: textureAtlas2.textureNamed("white"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition5 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 344)
        DNote.position = coinPosition5
        DNote.alpha = 1
        DNote.name = "pD"
        self.addChild(DNote)
        
        DSNote = SKSpriteNode(texture: textureAtlas2.textureNamed("black"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition6 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 316)
        DSNote.position = coinPosition6
        DSNote.alpha = 1
        DSNote.name = "pDS"
        self.addChild(DSNote)
        
        ENote = SKSpriteNode(texture: textureAtlas2.textureNamed("white"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition7 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 288)
        ENote.position = coinPosition7
        ENote.alpha = 1
        ENote.name = "pE"
        self.addChild(ENote)
        
        FNote = SKSpriteNode(texture: textureAtlas2.textureNamed("white"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition8 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 260)
        FNote.position = coinPosition8
        FNote.alpha = 1
        FNote.name = "pF"
        self.addChild(FNote)
        
        FSNote = SKSpriteNode(texture: textureAtlas2.textureNamed("black"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition9 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 232)
        FSNote.position = coinPosition9
        FSNote.alpha = 1
        FSNote.name = "pFS"
        self.addChild(FSNote)
        
        GNote = SKSpriteNode(texture: textureAtlas2.textureNamed("white"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition10 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 204)
        GNote.position = coinPosition10
        GNote.alpha = 1
        GNote.name = "pG"
        self.addChild(GNote)
        
        GSNote = SKSpriteNode(texture: textureAtlas2.textureNamed("black"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition11 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 176)
        GSNote.position = coinPosition11
        GSNote.alpha = 1
        GSNote.name = "pGS"
        self.addChild(GSNote)
        
        ANote = SKSpriteNode(texture: textureAtlas2.textureNamed("white"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition12 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 148)
        ANote.position = coinPosition12
        ANote.alpha = 1
        ANote.name = "pA"
        self.addChild(ANote)
        
        ASNote = SKSpriteNode(texture: textureAtlas2.textureNamed("black"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition13 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 120)
        ASNote.position = coinPosition13
        ASNote.alpha = 1
        ASNote.name = "pAS"
        self.addChild(ASNote)
        
        BNote = SKSpriteNode(texture: textureAtlas2.textureNamed("white"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition14 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 92)
        BNote.position = coinPosition14
        BNote.alpha = 1
        BNote.name = "pB"
        self.addChild(BNote)
        
        C4Note = SKSpriteNode(texture: textureAtlas2.textureNamed("white"), color: .clear, size: CGSize(width: 80 , height: (screenSize.height - 58)/13))
        let coinPosition15 = CGPoint(x: -cameraOrigin.x + 40, y: cameraOrigin.y - 64)
        C4Note.position = coinPosition15
        C4Note.alpha = 1
        C4Note.name = "pC4"
        self.addChild(C4Note)

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
    
    func resetbutton(){
        StartButton.texture = textureAtlas.textureNamed("start")
        status = true
    }
    
    func showmenu(){
        Piano.alpha = 0
        Violin.alpha = 0
        self.addChild(Piano)
        self.addChild(Violin)
        let fadeAnimation = SKAction.fadeAlpha(to: 1, duration: 0.4)
        Piano.run(fadeAnimation)
        Violin.run(fadeAnimation)
    }
    
    func hidemenu(){
        let fadeoutAnimation = SKAction.fadeAlpha(to: 0, duration: 0.4)
        Piano.run(fadeoutAnimation)
        Violin.run(fadeoutAnimation)
        Piano.removeFromParent()
        Violin.removeFromParent()
    }
    
    func changetempo(tempo: Int){
        Tempo.text = "Tempo: " + String(tempo)
    }
    
    func switchinstrument(name: String){
        if name == "piano" {
            Instrument.texture = textureAtlas.textureNamed("piano")
        }
        else if name == "violin" {
            Instrument.texture = textureAtlas.textureNamed("guitar")
        }
        
    }
}
