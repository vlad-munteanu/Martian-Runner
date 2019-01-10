//
//  AIScene.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/7/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import SpriteKit
import GameplayKit


var network = FFNN(inputs: 1, hidden: 300, outputs: 1)

class AIScene: SKScene, SKPhysicsContactDelegate {
   
    //AI Stuff
    var params: [[Float]] = []
    var doneFor: [Float] = []
    var answers: [[Float]] = []
    var neuralPlay = false
    
    var generationTimer: Timer?
    var closestBlock = 0
    let pauseLabel = SKLabelNode(fontNamed: "Pixel Miners")
    
    override func didMove(to view: SKView) {
        addEveryIntialThing()
        physicsWorld.contactDelegate = self
    }
    
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
        pauseLabel.fontSize = 12
        pauseLabel.fontColor = SKColor.black
        pauseLabel.position = CGPoint(x: size.width * 0.9, y: size.height * 0.9)
        pauseLabel.text = "Pause"
        pauseLabel.name = "pause"
        
        addChild(pauseLabel)
        
        //timer
        generationTimer = Timer.scheduledTimer(timeInterval: scoreTimerTime, target: self, selector: #selector(NormalGameScene.checkScore), userInfo: nil, repeats: true)
        
        
    }
    
    func addGameOver() {
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.fontColor = UIColor.black
        gameOverLabel.fontName = "Helvetica"
        gameOverLabel.position.x = view!.center.x
        gameOverLabel.position.y = view!.center.y + 40
        gameOverLabel.fontSize = 22.0
        addChild(gameOverLabel)
        gameOverLabel.run(blinkAnimation())
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(mainHero.position.y > brickHeight) {
        } else {
            mainHero.physicsBody?.applyForce(CGVector(dx: 0, dy: 16_000))
            //checkScore()
        }
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name {
            if name == "pause" {
                let scene = MainMenuScene(size: size)
                self.view?.presentScene(scene)
                
            }
            
        }
    }
    
    @objc func checkScore() {
        
        if (gameOver == false) {
            scoreLabel.increment()
            if(scoreLabel.number % 3 == 0) {
                floorGenerator.stop()
                floorGenerator.start()
                LevelNumber += 1
            }
            
            
        }
    }
    
    
    func resetGame() {
        
        enemyGenerator.onCollision()
        enemyTime = 0.8
        LevelNumber = 0
        likelyhoodOfWater = 0.01
        scoreTimerTime = 1
        xPerSec = 150.0
        
        if !(neuralPlay) {
            let res = params.cleanUp(withAnswers: answers)
            print("Old: \(params)")
            params = res.this
            answers = res.answers
            print("New: \(params)")
            print(answers)
            _ = try! network.train(inputs: params, answers: answers, testInputs: params, testAnswers: answers, errorThreshold: 0.1)
            print(network.getWeights())
        }
        
        let scene = AIScene(size: size)
        self.view?.presentScene(scene)
        
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

extension Array {
    
    func sample() -> (ele: Element, index: Int) {
        let randomIndex = Int(arc4random()) % count
        return (ele: self[randomIndex], index: randomIndex)
    }
    
    func cleanUp(withAnswers: [[Float]]) -> (this: [[Float]], answers: [[Float]]) {
        var amountZero = 0
        var amountOne = 0
        var result: (this: [[Float]], answers: [[Float]]) = (this: [], answers: [])
        var this: [[Float]] = []
        var answers: [[Float]] = []
        for (index, _) in self.enumerated() {
            if withAnswers[index] == [0] {
                amountZero += 1
            } else if withAnswers[index] == [1] {
                amountOne += 1
            }
        }
        for i in self {
            this.append(i as! [Float])
        }
        answers = withAnswers
        while (amountOne) < amountZero {
            var continueIt = true
            for (index, _) in this.enumerated() {
                if continueIt {
                    if answers[index] == [0] {
                        answers.remove(at: index)
                        this.remove(at: index)
                        continueIt = false
                    }
                }
            }
            amountOne = 0
            amountZero = 0
            for (index, _) in this.enumerated() {
                if answers[index] == [0] {
                    amountZero += 1
                } else if answers[index] == [1] {
                    amountOne += 1
                }
            }
        }
        result = (this: this, answers: answers)
        return result
    }
}
