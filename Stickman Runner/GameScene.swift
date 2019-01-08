//
//  GameScene.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/7/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import SpriteKit
import GameplayKit

var mainHero: SKStickMan!
var floorGenerator: SKFloorGenerator!

var scoreLabel: SKPointsLabel!

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    override func didMove(to view: SKView) {
        addEveryIntialThing()
        physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
       print("Contact occured")
        
        if contact.bodyA.categoryBitMask == waterAndSpikeCategory {
            contact.bodyA.node?.removeFromParent()
            resetGame()
        }
        if contact.bodyB.categoryBitMask == waterAndSpikeCategory {
            contact.bodyB.node?.removeFromParent()
            resetGame()
        }
        
        
    }
    
    func addEveryIntialThing() {
        //Stick Man
        mainHero = SKStickMan()
        mainHero.position = CGPoint(x:size.width*0.15, y:size.height*0.7)
        mainHero.run()
        addChild(mainHero)
        
        
        //floor
        floorGenerator = SKFloorGenerator(size: CGSize(width: view!.frame.width, height: brickHeight))
        floorGenerator.position = CGPoint(x: 0, y: size.height*0.01)
        addChild(floorGenerator)
        
        //Adding points and highscore label
        scoreLabel = SKPointsLabel(num: 0)
        scoreLabel.position = CGPoint(x: size.width*0.5, y: size.height*0.8)
        addChild(scoreLabel)
        
    }
    
    func addStartLabel() {
        let tapToStartLabel = SKLabelNode(text: "Tap to Bool!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position.x = view!.center.x
        tapToStartLabel.position.y = view!.center.y + 40
        tapToStartLabel.fontName = "Helvetica"
        tapToStartLabel.fontColor = UIColor.black
        tapToStartLabel.fontSize = 22.0
        addChild(tapToStartLabel)
        tapToStartLabel.run(blinkAnimation())
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
        
        mainHero.physicsBody?.applyForce(CGVector(dx: 0, dy: 200))
        
      
    }
    
    func resetGame() {
        // badCarGenerator.onCollision()
        //Creating the new scene
        
       // let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let scene = GameScene(size: size)
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
    }
}
