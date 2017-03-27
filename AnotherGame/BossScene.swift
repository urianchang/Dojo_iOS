//
//  BossScene.swift
//  MonSwifto
//
//  Created by Carolyn Yen on 3/12/17.
//  Copyright © 2017 frandz. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation
class BossScene: SKScene, SKPhysicsContactDelegate {
    let cam = SKCameraNode()
    let ground = Ground()
    let leftwall = Wall()
    let rightwall = Wall()
    let ceiling = Wall()
    let player = Player()
    let initialPlayerPosition = CGPoint(x:0, y:300)
    let boss = Boss()
    var screenCenterY = CGFloat()
    var screenCenterX = CGFloat()
    var playerProgress = CGFloat()
    var backgrounds:[Background] = []
    var lastTouch: CGPoint? = nil
    var coinsCollected = 3
    let hud = HUD()
    let fadeAnimation = SKAction.fadeAlpha(to: 1, duration: 3)
    let fadeoutAnimation = SKAction.fadeAlpha(to: 0, duration: 3)
    var status = true
    
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named:"Arrows")
    let GravityButton = SKSpriteNode()
    var upstatus = false
    var downstatus = true
    var leftstatus = false
    var rightstatus = false
    var gunstatus = false
    var attackvector = CGVector()
    var attackstatus: String = ""
    
    var musicPlayer = AVAudioPlayer()
    
//    var swipeRightRec = UISwipeGestureRecognizer()
//    var swipeLeftRec = UISwipeGestureRecognizer()
    
    override func didMove(to view: SKView) {
        
        self.scene?.size = self.view!.bounds.size
        
        if let musicPath = Bundle.main.path(forResource:
            "Sound/nightsky.mp3", ofType: nil) {
            let url = URL(fileURLWithPath: musicPath)
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer.numberOfLoops = -1
                musicPlayer.prepareToPlay()
                musicPlayer.play()
            }
            catch { /* Couldn't load music file */ }
        }
        
        
        print (frame.size)
        screenCenterY = self.size.height / 2
        screenCenterX = self.size.width / 2
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        self.camera = cam
        self.anchorPoint = .zero
        
//        swipeRightRec.addTarget(self, action: #selector(BossScene.swipedRight))
//        swipeRightRec.direction = .right
//        self.view!.addGestureRecognizer(swipeRightRec)
//        
//        swipeLeftRec.addTarget(self, action: #selector(BossScene.swipedLeft))
//        swipeLeftRec.direction = .left
//        self.view!.addGestureRecognizer(swipeLeftRec)
        
        
        boss.position = CGPoint(x: 265, y: 100)
        self.addChild(boss)
        
//        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//        borderBody.friction = 0
//        self.physicsBody = borderBody
        
        ground.position = CGPoint(x: -self.size.width * 2, y: 0)
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.createChildren()
        self.addChild(ground)
//
//        print(self.size.height/2)
//        
        leftwall.createChildren(topleft:CGPoint(x:-self.size.width/2-2, y:0), topright:CGPoint(x:-self.size.width/2-2, y:self.size.height), position:CGPoint(x:0, y:0))
        self.addChild(leftwall)
        
        rightwall.createChildren(topleft:CGPoint(x:self.size.width/2+2, y:0), topright:CGPoint(x:self.size.width/2+2, y:self.size.height), position:CGPoint(x:0, y:0))
        self.addChild(rightwall)
        
        ceiling.createChildren(topleft:CGPoint(x:-self.size.width/2-2, y:self.size.height), topright:CGPoint(x:self.size.width/2+2, y:self.size.height), position:CGPoint(x:0, y:0))
        self.addChild(ceiling)
        
        let initialPlayerPosition = CGPoint(x:0, y:self.size.height - 60)
        player.position = initialPlayerPosition
        self.addChild(player)
        
        for _ in 0..<3 {
            backgrounds.append(Background())
        }
        
        backgrounds[0].backgroundSize = CGSize(width: 1024, height: 768)
        backgrounds[0].position = CGPoint(x: 0, y: 0)
        backgrounds[0].zPosition = -5
        backgrounds[0].movementMultiplier = 0.75
        self.addChild(backgrounds[0])
        let texture = backgrounds[0].textureAtlas.textureNamed("darkforest")
        let newBGNode = SKSpriteNode(texture: texture)
        newBGNode.size = CGSize(width: 754, height: 868)
        backgrounds[0].addChild(newBGNode)

        self.physicsWorld.contactDelegate = self
        self.addChild(self.camera!)
        self.camera!.zPosition = 50
        hud.createHudNodes(screenSize: self.size)
        self.camera!.addChild(hud)
        hud.setCoinCountDisplay(newCoinCount: 3)
        
        hud.showLabel(changetext: "'I went to another world.'", changetext2: "", color: SKColor.red, size: 40)
        status = false
    
        hud.addGravity()
    }
    
    override func didSimulatePhysics() {
        let cameraYPos = screenCenterY
        cam.yScale = 1
        cam.xScale = 1
        self.camera!.position = CGPoint(x: 0, y: cameraYPos)
        playerProgress = player.position.x -
            initialPlayerPosition.x
        ground.checkForReposition(playerProgress: playerProgress)
    }
    
    
    
//    func didBegin(_ contact: SKPhysicsContact) {
//        var firstBody: SKPhysicsBody
//        var secondBody: SKPhysicsBody
//        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
//            firstBody = contact.bodyA
//            secondBody = contact.bodyB
//        } else {
//            firstBody = contact.bodyB
//            secondBody = contact.bodyA
//        }
//        if ((firstBody.categoryBitMask & shipCategory != 0) &&
//            (secondBody.categoryBitMask & balloonCategory != 0)) {
//            if let _ = firstBody.node as? SKSpriteNode, let
//                balloon = secondBody.node as? SKSpriteNode {
//                shipHitBalloon(balloon: balloon)
//            }
//        }
//    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let firstBody = contact.bodyA.categoryBitMask
        let secondBody = contact.bodyB.categoryBitMask
        
        print ("First \(firstBody)")
        print ("Second \(secondBody)")
        
        //: Check for bullet and enemy collision
        if (firstBody == 8 && secondBody == 256) || (firstBody == 256 && secondBody == 8) {
            print ("pewpew hit bad guy")
            boss.takeDamage()
            let bee = Bee()
            bee.position = CGPoint(x: boss.position.x, y: boss.position.y)
            self.addChild(bee)
            bee.physicsBody?.velocity = CGVector(dx:-80, dy:0)
        }
        //: Check for enemy and player collision
        if (firstBody == 1 && secondBody == 8) || (firstBody == 8 && secondBody == 1) {
            print ("GAH. I got hit")
            player.takeDamage()
            hud.setHealthDisplay(newHealth: player.health)
        }
        
//        if (contact.bodyA.categoryBitMask == PhysicsCategory.enemy.rawValue && contact.bodyB.categoryBitMask == PhysicsCategory.enemy.rawValue) ||
//            (contact.bodyA.categoryBitMask == PhysicsCategory.enemy.rawValue && contact.bodyB.categoryBitMask == PhysicsCategory.enemy.rawValue) ||
//            (contact.bodyA.categoryBitMask == PhysicsCategory.enemy.rawValue && contact.bodyB.categoryBitMask == PhysicsCategory.ground.rawValue) ||
//            (contact.bodyA.categoryBitMask == PhysicsCategory.ground.rawValue && contact.bodyB.categoryBitMask == PhysicsCategory.enemy.rawValue)
//            {
//                print("no damage")
//                return
//            } else if (contact.bodyA.categoryBitMask == PhysicsCategory.bullet.rawValue && contact.bodyB.categoryBitMask == PhysicsCategory.enemy.rawValue) || (contact.bodyB.categoryBitMask == PhysicsCategory.bullet.rawValue && contact.bodyA.categoryBitMask == PhysicsCategory.enemy.rawValue)
//            {
//                print("Ouch!")
//                boss.takeDamage()
//                let bee = Bee()
//                bee.position = CGPoint(x: boss.position.x, y: boss.position.y)
//                self.addChild(bee)
//                bee.physicsBody?.velocity = CGVector(dx:-80, dy:0)
//                return
//            }
//        else {
//            var otherBody:SKPhysicsBody
//            let penguinMask = PhysicsCategory.penguin.rawValue | PhysicsCategory.damagedPenguin.rawValue
//            if (contact.bodyA.categoryBitMask & penguinMask) > 0 {
//                otherBody = contact.bodyB
//            } else {
//                otherBody = contact.bodyA
//            }
//            switch otherBody.categoryBitMask {
//            case PhysicsCategory.ground.rawValue:
//                print("")
//            case PhysicsCategory.enemy.rawValue:
//                print("take damage from\(otherBody.node!)")
//                player.takeDamage()
//                hud.setHealthDisplay(newHealth: player.health)
//            case PhysicsCategory.coin.rawValue:
//                print("coin!!!")
//            case PhysicsCategory.powerup.rawValue:
//                print("star")
//            case PhysicsCategory.rock.rawValue:
//                print("rock")
//            case PhysicsCategory.tree.rawValue:
//                print("tree")
//            case PhysicsCategory.bullet.rawValue:
//                print("bullet")
//            default:
//                print (otherBody.categoryBitMask)   //: Getting 1 and 2 when player is loaded -- penguin and damagedPenguin
//                print("Contact")
//            }
//        }
    }
    
    func gameOver() {
        player.removeFromParent()
        hud.showButtons()
    }
    
    func gameWin() {
        player.removeFromParent()
        hud.showWin()
    }
    
//    func swipedRight() {
//        print("went right")
//        player.stopFlapping()
//        move(theAnimation: "attackRight")
//    }
//    
//    func swipedLeft(){
//        print("went left")
//        player.stopFlapping()
//        move(theAnimation: "attackLeft")
//    }
//    
//    func move(theAnimation:String){
//        if theAnimation == "attackRight" {
//            player.attackRight()
//        }
//        else if theAnimation == "attackLeft" {
//            player.attackLeft()
//        }
//    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if (nodeTouched.name != "Up") && (nodeTouched.name != "Left") && (nodeTouched.name != "Right") && (nodeTouched.name != "Down") && (nodeTouched.name != "Gun") {
                lastTouch = location
            }
            if let gameSprite = nodeTouched as? GameSprite {
                gameSprite.onTap()
            }
            if nodeTouched.name == "restartGame" {
                self.view?.presentScene(GameScene(size: self.size), transition: .crossFade(withDuration: 0.6))
            }
            else if nodeTouched.name == "returnToMenu" {
                self.view?.presentScene(MenuScene(size: self.size), transition: .crossFade(withDuration: 0.6))
            }
            else if nodeTouched.name == "Up" {
                if upstatus == false && downstatus == true{
                    player.turnup()
                    let rotateaction = SKAction.rotate(byAngle: CGFloat.pi, duration: 1)
                    self.camera!.run(rotateaction)
                    upstatus = true
                    downstatus = false
                }
                if leftstatus == true {
                    let flipnegative = SKAction.rotate(byAngle: CGFloat.pi/2, duration:1)
                    player.run(flipnegative)
                    leftstatus = false
                    upstatus = true
                    downstatus = false
                }
                if rightstatus == true {
                    let flipnegative = SKAction.rotate(byAngle: -CGFloat.pi/2, duration:1)
                    player.run(flipnegative)
                    rightstatus = false
                    upstatus = true
                    downstatus = false
                }
                self.physicsWorld.gravity = CGVector(dx: 0, dy: 4)
                print("up")
            }
            else if nodeTouched.name == "Left" {
                if leftstatus != true {
                if upstatus == true && downstatus == false {
                    let rotateaction = SKAction.rotate(byAngle: CGFloat.pi, duration: 1)
                    self.camera!.run(rotateaction)
                    let flipnegative = SKAction.rotate(byAngle: CGFloat.pi, duration:1)
                    player.run(flipnegative)
                    leftstatus = true
                    upstatus = false
                    downstatus = true
                }
                if downstatus == true && upstatus == false {
                    let flipnegative = SKAction.rotate(byAngle: -CGFloat.pi/2, duration:1)
                    player.run(flipnegative)
                    leftstatus = true
                }
                if rightstatus == true && upstatus == false {
                    let flipnegative = SKAction.rotate(byAngle: -CGFloat.pi/2, duration:1)
                    player.run(flipnegative)
                    rightstatus = false
                    leftstatus = true
                }
                print("left")
                self.physicsWorld.gravity = CGVector(dx: -4, dy: 0)
                }
            }
            else if nodeTouched.name == "Right" {
                if rightstatus != true {
                if upstatus == true && downstatus == false {
                    let rotateaction = SKAction.rotate(byAngle: CGFloat.pi, duration: 1)
                    self.camera!.run(rotateaction)
                    let flipnegative = SKAction.rotate(byAngle: CGFloat.pi, duration:1)
                    player.run(flipnegative)
                    rightstatus = true
                    upstatus = false
                    downstatus = true
                }
                if downstatus == true && upstatus == false {
                    let flipnegative = SKAction.rotate(byAngle: CGFloat.pi/2, duration:1)
                    player.run(flipnegative)
                    rightstatus = true
                }
                if leftstatus == true && upstatus == false {
                    let flipnegative = SKAction.rotate(byAngle: CGFloat.pi/2, duration:1)
                    player.run(flipnegative)
                    leftstatus = false
                    rightstatus = true
                }
                print("right")
                self.physicsWorld.gravity = CGVector(dx: 4, dy: 0)
                }
            }
            else if nodeTouched.name == "Down" {
                if downstatus == false && upstatus == true{
                    player.turnup()
                    let rotateaction = SKAction.rotate(byAngle: CGFloat.pi, duration: 1)
                    self.camera!.run(rotateaction)
                    downstatus = true
                }
                if leftstatus == true {
                    let flipnegative = SKAction.rotate(byAngle: CGFloat.pi/2, duration:1)
                    player.run(flipnegative)
                    leftstatus = false
                    downstatus = true
                }
                if rightstatus == true {
                    let flipnegative = SKAction.rotate(byAngle: -CGFloat.pi/2, duration:1)
                    player.run(flipnegative)
                    rightstatus = false
                    downstatus = true
                }
                self.physicsWorld.gravity = CGVector(dx: 0, dy: -4)
                upstatus = false
                print("down")
            }
            else if nodeTouched.name == "Gun" {
                if gunstatus == false {
                    gunstatus = true
                    print("gun on")
                    hud.changeGun(text: "On", color: SKColor.green)
                    player.attackRight()
                }
                else {
                    gunstatus = false
                    hud.changeGun(text: "Off", color: SKColor.blue)
                }
            }
            if gunstatus == true {
                player.attackRight()
                let bullet = Bullet()
                bullet.position = player.position
                self.addChild(bullet)
                let flipnegative2 = SKAction.scaleY(to: -1, duration:0)
                bullet.run(flipnegative2)
                let flipnegative = SKAction.scaleX(to: -1, duration:0)
                bullet.run(flipnegative)
                if attackstatus == "UL" {
                    attackvector = CGVector(dx:-100, dy:0)
                }
                else if attackstatus == "UR" {
                    attackvector = CGVector(dx:100, dy:0)
                }
                else if attackstatus == "DL" {
                    attackvector = CGVector(dx:-100, dy:0)
                }
                else if attackstatus == "DR" {
                    attackvector = CGVector(dx:100, dy:0)
                }
                else if attackstatus == "LD" {
                    attackvector = CGVector(dx:0, dy:-100)
                }
                else if attackstatus == "LU" {
                    attackvector = CGVector(dx:0, dy:100)
                }
                else if attackstatus == "RD" {
                    attackvector = CGVector(dx:0, dy:-100)
                }
                else if attackstatus == "RU" {
                    attackvector = CGVector(dx:0, dy:100)
                }
                else {
                    attackvector = CGVector(dx:100, dy:0)
                }
                bullet.physicsBody?.velocity = attackvector
            }
            else {
                player.startFlapping()
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        if gunstatus == false {
            player.stopFlapping()
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>,
                                   with event: UIEvent?) {
        if gunstatus == false {
            player.stopFlapping()
        }
    }
  
    override func update(_ currentTime: TimeInterval) {
        if player.flapping {
            if leftstatus == true {
                if let touch = lastTouch {
                    if (touch.y - player.position.y) < 0 {
                        let flipnegative = SKAction.scaleX(to: 1, duration:0)
                        player.run(flipnegative)
                        attackstatus = "LD"
                    }
                    else    {
                        let flipnegative = SKAction.scaleX(to: -1, duration:0)
                        player.run(flipnegative)
                        attackstatus = "LU"
                    }
                    player.physicsBody?.velocity = CGVector(dx:0, dy:(touch.y - player.position.y)*1.2)
                }
            }
            else if rightstatus == true {
                if let touch = lastTouch {
                    if (touch.y - player.position.y) < 0 {
                        let flipnegative = SKAction.scaleX(to: -1, duration:0)
                        player.run(flipnegative)
                        attackstatus = "RD"
                    }
                    else    {
                        let flipnegative = SKAction.scaleX(to: 1, duration:0)
                        player.run(flipnegative)
                        attackstatus = "RU"
                    }
                    player.physicsBody?.velocity = CGVector(dx:0, dy:(touch.y - player.position.y)*1.2)
                }
            }
            else if upstatus == true {
                if let touch = lastTouch {
                    if (touch.x - player.position.x) < 0 {
                        player.turnback2()
                        attackstatus = "UL"
                    }
                    else    {
                        player.turnfront2()
                        attackstatus = "UR"
                    }
                    player.physicsBody?.velocity = CGVector(dx:(touch.x - player.position.x) * 1.2 , dy: 0)
                }
            }
            else {
                if let touch = lastTouch {
                    if (touch.x - player.position.x) < 0 {
                        player.turnback()
                        attackstatus = "DL"
                    }
                    else    {
                        player.turnfront()
                        attackstatus = "DR"
                    }
                    player.physicsBody?.velocity = CGVector(dx:(touch.x - player.position.x) * 1.2 , dy: 0)
                }
                if status == false {
                    hud.fadeLabel()
                    status = true
                }
            }
            
        }
    }
}










