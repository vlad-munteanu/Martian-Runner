//
//  GameScene.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/7/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import SpriteKit
import GameplayKit


var currentNeuralNetwork = FFNN(inputs: 1, hidden: 300, outputs: 1)

class NormalGameScene: SKScene, SKPhysicsContactDelegate {
    
    //AI Stuff
    var parameters: [[Float]] = []
    var indexArray: [Float] = []
    var neuralAnswers: [[Float]] = []

    var mainHero: SKStickMan!
    var enemyGenerator: SKEnemyGenerator!
    
    var floorGenerator: SKFloorGenerator!
    var cloudGenerator: SKCloudGenerator!
    
    var closestEnemyXPos: CGFloat = 0.0
    
    var scoreLabel: SKPointsLabel!
    
    var highScore = UserDefaults.standard.integer(forKey: "highscore")
    
    var generationTimer: Timer?

    let pauseLabel = SKLabelNode(fontNamed: "Pixel Miners")
    var isOnGround = true
    

    
    var highScoreLabel: SKPointsLabel!
    
    //GameOver
    
    
    
    override func didMove(to view: SKView) {
        addEveryIntialThing()
        physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0,dy: -20.0)
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
        
        parameters.append([Float(closestEnemyXPos)])
        neuralAnswers.append([1])
        indexArray.append(Float(closestEnemyXPos))
        if(mainHero.position.y > brickHeight) {
        } else {
            mainHero.physicsBody?.applyForce(CGVector(dx: 0, dy: 20_000))
        }
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name {
            if name == "pause" {
                enemyGenerator.onCollision()
                closestEnemyXPos = 0.0
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
            print(closestEnemyXPos)
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
        
        let res = parameters.cleanUp(withAnswers: neuralAnswers)
    
        parameters = res.this
        neuralAnswers = res.answers
      
        print(neuralAnswers)
        _ = try? currentNeuralNetwork.train(inputs: parameters, answers: neuralAnswers, testInputs: parameters, testAnswers: neuralAnswers, errorThreshold: 0.02)
        
        print("weights\(currentNeuralNetwork.getWeights())")
        
        defaults.set(currentNeuralNetwork.getWeights(), forKey: currentName)
        
        print("going to AI Scene now")
        
        enemyGenerator.onCollision()
        closestEnemyXPos = 0
        
        LevelNumber = 0
        likelyhoodOfWater = 0.01
        scoreTimerTime = 1
        xPerSec = 150.0
        
        let scene = ChooseNetwork(size: size)
        self.view?.presentScene(scene)
        
    
        
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //make sure stickman stays in place
        mainHero.position.x = size.width*0.15
        if(mainHero.position.y < -size.height) {
          //  resetGame()
        }
        if(mainHero.position.y >= size.height) {
            mainHero.position.y = size.height - mainHero.size.height
        }
        
        if(mainHero.position.y > brickHeight) {
            isOnGround = false
        } else {
            isOnGround = true
        }
        
        
        
        if !(indexArray.contains(Float(closestEnemyXPos))) {
            parameters.append([Float(closestEnemyXPos)])
            neuralAnswers.append([0])
       }
        
        checkScore()
        print(neuralAnswers.last ?? "")
        
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
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

