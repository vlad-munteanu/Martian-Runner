//
//  AIScene.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/7/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import SpriteKit
import GameplayKit


class AIScene: SKScene, SKPhysicsContactDelegate {
   
    
    var isOnGround = true

    var mainHero: SKStickMan!
    var enemyGenerator: SKEnemyGenerator!
    
    var floorGenerator: SKFloorGenerator!
    var cloudGenerator: SKCloudGenerator!
    
    
    var closestEnemyXPos: CGFloat = 0.0
    var scoreLabel: SKPointsLabel!
    
    var highScore = UserDefaults.standard.integer(forKey: "highscore")
    
    var generationTimer: Timer?
    var closestEnemy = 0
    let pauseLabel = SKLabelNode(fontNamed: "Pixel Miners")
    
    override func didMove(to view: SKView) {
        addEveryIntialThing()
        physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0,dy: -15.0)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("Contact occured")
        
        if contact.bodyA.categoryBitMask == badGuyCategory {
            contact.bodyA.node?.removeFromParent()
            gameOver()
            
        }
        if contact.bodyB.categoryBitMask == badGuyCategory {
            contact.bodyB.node?.removeFromParent()
            gameOver()
        }
        
        
    }
    
    func addEveryIntialThing() {
        //Background
        backgroundColor = #colorLiteral(red: 0, green: 0.4793452024, blue: 0.9990863204, alpha: 1)
        
        //Stick Man
        mainHero = SKStickMan()
        mainHero.position = CGPoint(x:size.width*0.15, y:brickHeight)
        mainHero.run()
        addChild(mainHero)
        
        //Stick Man
        enemyGenerator = SKEnemyGenerator()
        enemyGenerator.position = CGPoint(x: size.width-50,y: size.height * 0.1)
        enemyGenerator.generateBadGuys()
        addChild(enemyGenerator)
        
        
        //floor
        floorGenerator = SKFloorGenerator(size: CGSize(width: view!.frame.width, height: brickHeight))
        floorGenerator.start()
        floorGenerator.position = CGPoint(x: 0, y: size.height*0.01)
        addChild(floorGenerator)
        
        //Adding points and highscore label
        scoreLabel = SKPointsLabel(num: 0)
        scoreLabel.position = CGPoint(x: size.width*0.5, y: size.height*0.8)
        addChild(scoreLabel)
        
        //Creating the Clouds
        cloudGenerator = SKCloudGenerator(texture: nil, color: UIColor.clear, size: view!.frame.size)
        cloudGenerator.position = view!.center
        addChild(cloudGenerator)
        cloudGenerator.populate(num: 7)
        cloudGenerator.startGeneratingMoreClouds(spawnTime: 10)
        
        //pauseButton
        pauseLabel.fontSize = 16
        pauseLabel.fontColor = SKColor.black
        pauseLabel.position = CGPoint(x: size.width * 0.9, y: size.height * 0.9)
        pauseLabel.text = "Home"
        pauseLabel.name = "pause"
        
        addChild(pauseLabel)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name {
            if name == "pause" {
                enemyGenerator.onCollision()
                closestEnemy = 0
                LevelNumber = 0
                likelyhoodOfWater = 0.01
                scoreTimerTime = 1
                xPerSec = 150.0
                let scene = MainMenuScene(size: size)
                self.view?.presentScene(scene)
                
            }
            
        }
    }
    
    @objc func checkScore() {
        
        
        if enemyGenerator.allEnemies.count > 0 {
            let enemyPosition = enemyGenerator.convert(enemyGenerator.allEnemies[0].position, to: self)
            
            if(enemyPosition.x < 200) {
                let networkValue = try! currentNeuralNetwork.update(inputs: [Float(closestEnemyXPos)]).first!
                let networkWantsToJump = networkValue > 0.99
                print("Network value: \(networkValue) \(networkWantsToJump)")
                if networkWantsToJump && isOnGround{
                    mainHero.physicsBody?.applyForce(CGVector(dx: 0, dy: 20_000))
                    isOnGround = false
                } else if !(networkWantsToJump) {
                    isOnGround = true
                }
            }
            
            closestEnemyXPos = enemyPosition.x
            if (closestEnemyXPos < mainHero.position.x)
            {
                
                enemyGenerator.allEnemies.remove(at: 0)
                scoreLabel.increment()
                
                if(scoreLabel.number % 3 == 0) {
                    
                    floorGenerator.stop()
                    floorGenerator.start()
                    
                    
                    enemyGenerator.restart()
                    
                    LevelNumber += 1
                    backgroundColor = .random()
                }
            }
            
            
        }
    }
    
    func gameOver() {
        cloudGenerator.stopGeneratingMoreClouds()
        let defaults = UserDefaults.standard
        if highScore < scoreLabel.number  {
            highScore = scoreLabel.number
            
            defaults.set(highScore, forKey: "highscore")
        }
        
        print("High Score: \(UserDefaults.standard.integer(forKey: "highscore"))")
       
        enemyGenerator.onCollision()
        closestEnemy = 0
        
        LevelNumber = 0
        likelyhoodOfWater = 0.01
        scoreTimerTime = 1
        xPerSec = 150.0
        
        let scene = MainMenuScene(size: size)
        self.view?.presentScene(scene)
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        //make sure stickman stays in place
        mainHero.position.x = size.width*0.15
        if(mainHero.position.y < -size.height) {
            gameOver()
        }
        if(mainHero.position.y >= size.height) {
            mainHero.position.y = size.height - mainHero.size.height
        }
        if(mainHero.position.y > brickHeight) {
            isOnGround = false
        } else {
            isOnGround = true
        }
        checkScore()
        
       
    }
}



