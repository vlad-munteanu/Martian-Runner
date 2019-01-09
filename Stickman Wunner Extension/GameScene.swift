//
//  GameScene.swift
//  Stickman Wunner Extension
//
//  Created by Vlad Munteanu on 1/9/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import SpriteKit

var mainHero: SKStickMan!
var enemyGenerator: SKEnemyGenerator!

var floorGenerator: SKFloorGenerator!
var cloudGenerator: SKCloudGenerator!
var gameOver: Bool = false
var scoreLabel: SKPointsLabel!


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var generationTimer: Timer?
    var closestEnemy = 0
    let pauseLabel = SKLabelNode(fontNamed: "Pixel Miners")
    
//    override func didMove(to view: SKView) {
//        addEveryIntialThing()
//        physicsWorld.contactDelegate = self
//    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("Contact occured")
        
        if contact.bodyA.categoryBitMask == badGuyCategory {
            contact.bodyA.node?.removeFromParent()
            resetGame()
        }
        if contact.bodyB.categoryBitMask == badGuyCategory {
            contact.bodyB.node?.removeFromParent()
            resetGame()
        }
        
        
    }
    
    func addEveryIntialThing() {
        //Background
        backgroundColor = #colorLiteral(red: 0, green: 0.4793452024, blue: 0.9990863204, alpha: 1)
        
        //Stick Man
        mainHero = SKStickMan()
        mainHero.position = CGPoint(x:size.width*0.15, y:size.height*0.7)
        mainHero.run()
        addChild(mainHero)
        
        //Stick Man
        enemyGenerator = SKEnemyGenerator()
        
        enemyGenerator.position = CGPoint(x: size.width ,y: size.height*0.7)
        enemyGenerator.startGeneratingMoreEnemies(spawnTime: 1.5)
        addChild(enemyGenerator)
        
        
        //floor
//        floorGenerator = SKFloorGenerator(size: CGSize(width: view!.frame.width, height: brickHeight))
//        floorGenerator.start()
//        floorGenerator.position = CGPoint(x: 0, y: size.height*0.01)
//        addChild(floorGenerator)
        
        //Adding points and highscore label
        scoreLabel = SKPointsLabel(num: 0)
        scoreLabel.position = CGPoint(x: size.width*0.5, y: size.height*0.8)
        addChild(scoreLabel)
        
        //Creating the Clouds
//        cloudGenerator = SKCloudGenerator(texture: nil, color: UIColor.clear, size: view!.frame.size)
//        cloudGenerator.position = view!.center
//        addChild(cloudGenerator)
//        cloudGenerator.populate(num: 7)
//        cloudGenerator.startGeneratingMoreClouds(spawnTime: 10)
        
        //pauseButton
        pauseLabel.fontSize = 12
        pauseLabel.fontColor = SKColor.black
        pauseLabel.position = CGPoint(x: size.width * 0.9, y: size.height * 0.9)
        pauseLabel.text = "Pause"
        pauseLabel.name = "pause"
        
        addChild(pauseLabel)
        
        
        
        
    }
    
    
    @objc func checkScore() {
        if enemyGenerator.allEnemies.count > 0 {
            if (mainHero.position.x > (enemyGenerator.allEnemies[0].position.x))
            {
                print(enemyGenerator.allEnemies[0].position.x)
                print(mainHero.position.x)
                scoreLabel.increment()
                enemyGenerator.allEnemies[0].removeFromParent()
                enemyGenerator.allEnemies.remove(at: 0)
                
                if(scoreLabel.number % 3 == 0) {
                    floorGenerator.stop()
                    floorGenerator.start()
                    LevelNumber += 1
                }
            }
            
            
        }
    }
    
    
    func resetGame() {
        //Creating the new scene
        // let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        enemyGenerator.onCollision()
        closestEnemy = 0
        enemySpeed = 150
        LevelNumber = 0
        likelyhoodOfWater = 0.01
        scoreTimerTime = 1
        xPerSec = 150.0
        
        let scene = GameScene(size: size)
        //self.view?.presentScene(scene)
        
    }
    func blinkAnimation() -> SKAction {
        
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.6)
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.6)
        
        let blink = SKAction.repeatForever(SKAction.sequence([fadeOut,fadeIn]))
        return blink
    }
    
    @objc func setUp() {
        removeItems()
    }
    
    func removeItems() {
        for child in children {
            if child.position.y <= -self.size.height-100 {
                child.removeFromParent()
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //make sure stickman stays in place
        mainHero.position.x = size.width*0.15
        if(mainHero.position.y < -size.height) {
            resetGame()
        }
        if(mainHero.position.y >= size.height) {
            mainHero.position.y = size.height - mainHero.size.height
        }
        
    }
}
