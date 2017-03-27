//
//  GameScene.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/11/17.
//  Copyright © 2017 frandz. All rights reserved.
//
import SpriteKit
import AVFoundation
class GameScene: SKScene, SKPhysicsContactDelegate {
    let cam = SKCameraNode()
    let ground = Ground()
    let player = Player()
    var screenCenterY = CGFloat()
    var screenCenterX = CGFloat()
    let initialPlayerPosition = CGPoint(x: -20, y: 180)
    var playerProgress = CGFloat()
    var backgrounds:[Background] = []
    var lastTouch: CGPoint? = nil
    var coinsCollected = 0
    let hud = HUD()
    let fadeAnimation = SKAction.fadeAlpha(to: 1, duration: 3)
    let fadeoutAnimation = SKAction.fadeAlpha(to: 0, duration: 3)
    var status = false
    var treestatus = 0
    var status2 = false
    var gotstar = false
    var rockstatus = false
    var musicPlayer = AVAudioPlayer()
    
    override func didMove(to view: SKView) {
        
//        self.scene?.size = self.view!.bounds.size
        if let musicPath = Bundle.main.path(forResource:
            "Sound/instant.mp3", ofType: nil) {
            let url = URL(fileURLWithPath: musicPath)
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer.numberOfLoops = -1
                musicPlayer.prepareToPlay()
                musicPlayer.play()
            }
            catch { /* Couldn't load music file */ }
        }
        
        print ("Size height: \(size.height)")
        print ("Size width: \(size.width)")
        print ("Frame height: \(frame.height)")
        print ("Frame width: \(frame.width)")
        
        screenCenterY = self.size.height / 2
        screenCenterX = self.size.width / 2
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        self.anchorPoint = .zero
        self.camera = cam
        
        let bee2 = Bee()
        bee2.position = CGPoint(x: 325, y: 325)
        self.addChild(bee2)
        let bee3 = Bee()
        bee3.position = CGPoint(x: 200, y: 325)
        self.addChild(bee3)
        
        let staff1 = Staff()
        staff1.position = CGPoint(x: 100, y: 325)
        self.addChild(staff1)
        
        let staff2 = Staff()
        staff2.texture = SKTextureAtlas(named:"Staff").textureNamed("staff2")
        staff2.position = CGPoint(x: 50, y: 325)
        self.addChild(staff2)
        
        let staff3 = Staff()
        staff3.texture = SKTextureAtlas(named:"Staff").textureNamed("staff3")
        staff3.position = CGPoint(x: -600, y: 325)
        self.addChild(staff3)
        
        let tree = Tree()
        tree.position = CGPoint(x: 500, y: 220)
        self.addChild(tree)
        
        let rock = Rock()
        rock.position = CGPoint(x: -950, y: 140)
        self.addChild(rock)
        
        ground.position = CGPoint(x: -self.size.width * 2, y: 100)
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.createChildren()
        self.addChild(ground)
        
        player.position = initialPlayerPosition
        self.addChild(player)
        
        for _ in 0..<3 {
            backgrounds.append(Background())
        }
        backgrounds[0].spawn(parentNode: self,
                             imageName: "forest", zPosition: -5,
                             movementMultiplier: 0.75)
        
        self.physicsWorld.contactDelegate = self
        self.addChild(self.camera!)
        self.camera!.zPosition = 50
        hud.createHudNodes(screenSize: self.size)
        self.camera!.addChild(hud)
        
        hud.showLabel(changetext: "'I need to collect all the wand pieces.'", changetext2: "", color: SKColor.blue, size: 28)
    }
    
    override func didSimulatePhysics() {
        let cameraYPos = screenCenterY
        cam.yScale = 1
        cam.xScale = 1
        self.camera!.position = CGPoint(x: player.position.x,
                                        y: cameraYPos)
        
        playerProgress = player.position.x -
            initialPlayerPosition.x
        ground.checkForReposition(playerProgress: playerProgress)
        
        for background in self.backgrounds {
            background.updatePosition(playerProgress:
                playerProgress)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let otherBody:SKPhysicsBody
        let penguinMask = PhysicsCategory.penguin.rawValue |
            PhysicsCategory.damagedPenguin.rawValue
        if (contact.bodyA.categoryBitMask & penguinMask) > 0 {
            otherBody = contact.bodyB
        }
        else {
            otherBody = contact.bodyA
        }
        switch otherBody.categoryBitMask {
        case PhysicsCategory.ground.rawValue:
            print("hit the ground")
        case PhysicsCategory.enemy.rawValue:
            print("take damage")
            player.takeDamage()
            hud.setHealthDisplay(newHealth: player.health)
        case PhysicsCategory.coin.rawValue:
            print("coin!!!")
            if let coin = otherBody.node as? Staff {
                coin.collect()
                self.coinsCollected += coin.value
                status = false
                hud.setCoinCountDisplay(newCoinCount: self.coinsCollected)
            }
            if self.coinsCollected == 1 {
                hud.showLabel(changetext: "\(3-self.coinsCollected) wand pieces left", changetext2: "", color: SKColor.blue, size: 30)
            }
            else if self.coinsCollected == 2 {
                hud.showLabel(changetext: "\(3-self.coinsCollected) wand piece left", changetext2: "", color: SKColor.blue, size: 30)
            }
            else if self.coinsCollected == 3 {
                hud.showLabel(changetext: "'No wand pieces left.'", changetext2: "'The tree mentioned a boulder?'", color: SKColor.red, size: 30)
                gotstar = true
            }
        case PhysicsCategory.powerup.rawValue:
            print("start the power-up")
            self.view?.presentScene(BossScene(size: self.size))
        case PhysicsCategory.rock.rawValue:
            rockstatus = true
            if rockstatus == true && gotstar == true {
                print ("new star")
                let star = Star()
                star.position = CGPoint(x: -495, y: 120)
                self.addChild(star)
                rockstatus = false
                gotstar = false
            }
            else {
                hud.showLabel(changetext: "'There's nothing here..right?'", changetext2: "", color: SKColor.red, size: 30)
            }
        case PhysicsCategory.tree.rawValue:
            print("tree")
            print(treestatus)
            if treestatus == 0 {
                hud.showLabel(changetext: "'Teehee.'", changetext2: "", color: SKColor.red, size: 40)
                status2 = true
            }
            else if treestatus == 1 {
                hud.showLabel(changetext: "'You need to collect all", changetext2: "the wand pieces to pass, ok?'", color: SKColor.red, size: 30)
                status2 = true
            }
            else {
                hud.showLabel(changetext: "'Hint: Look behind the boulder.",  changetext2: ":)", color: SKColor.red, size: 32)
                status2 = true
            }
            
        default:
            print("Contact")
        }
      }
    
    func gameOver() {
        hud.showButtons()
    }
    
    func gameWin() {
        hud.showWin()
    }

    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            lastTouch = location
            if let gameSprite = nodeTouched as? GameSprite {
                gameSprite.onTap()
            }
            if nodeTouched.name == "restartGame" {
                self.view?.presentScene(GameScene(size: self.size), transition: .crossFade(withDuration: 0.6))
            }
            else if nodeTouched.name == "returnToMenu" {
                self.view?.presentScene(MenuScene(size: self.size), transition: .crossFade(withDuration: 0.6))
            }
        }
        player.startFlapping()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        player.stopFlapping()
    }
    override func touchesCancelled(_ touches: Set<UITouch>,
                                   with event: UIEvent?) {
        player.stopFlapping()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if player.flapping {
            if let touch = lastTouch {
                if (touch.x - player.position.x) < 0 {
                    player.turnback()
                    if treestatus == 0 && status2 == true {
                        hud.fadeLabel()
                        treestatus += 1
                        status2 = false
                    }
                    else if treestatus == 1 && status2 == true {
                        hud.fadeLabel()
                        status2 = false
                        treestatus += 1
                    }
                    else if treestatus == 2 && status2 == true {
                        hud.fadeLabel()
                        status2 = false
                        treestatus += 1
                    }
                }
                else {
                    player.turnfront()
                }
                player.physicsBody?.velocity = CGVector(dx:(touch.x - player.position.x) * 1.2 , dy: 0)
            }
            if status == false {
                hud.fadeLabel()
                status = true
            }
            if rockstatus == true{
                hud.fadeLabel()
                rockstatus = false
            }
        }
    }
}

enum PhysicsCategory:UInt32 {
    case penguin = 1
    case damagedPenguin = 2
    case ground = 4
    case enemy = 8
    case coin = 16
    case powerup = 32
    case tree = 64
    case rock = 128
    case bullet = 256
}




