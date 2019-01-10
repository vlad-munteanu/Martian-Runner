//
//  MainMenu.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/7/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import SpriteKit

class MainMenuScene : SKScene {
    
    let normalLabel = SKLabelNode(fontNamed: "Pixel Miners")
    let AILabel = SKLabelNode(fontNamed: "Pixel Miners")
    let highScoreLabel = SKLabelNode(fontNamed: "Pixel Miners")
    let mainLabel = SKLabelNode(fontNamed: "Pixel Miners")
    let settingsButton = SKSpriteNode(imageNamed: "settings")
    let background = SKSpriteNode(imageNamed: "bg")
    
    override func didMove(to view: SKView) {
    
        // set size, color, position and text of the tapStartLabel
        normalLabel.fontSize = 24
        normalLabel.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        normalLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.3)
        normalLabel.text = "Normal Mode"
        normalLabel.name = "Normal"
        normalLabel.zPosition = 1
        
        // set size, color, position and text of the tapStartLabel
        AILabel.fontSize = 24
        AILabel.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        AILabel.position = CGPoint(x: size.width / 2, y: size.height * 0.4 )
        AILabel.text = "AI Mode"
        AILabel.name = "AI"
        AILabel.zPosition = 1
        
        
//        highScoreLabel.fontSize = 10
//        highScoreLabel.fontColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        highScoreLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.9)
//        highScoreLabel.text = "Highscore: \(9)"
//        highScoreLabel.name = "HS"
//        highScoreLabel.zPosition = 1
        
        mainLabel.fontSize = 36
        mainLabel.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        mainLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.75)
        mainLabel.text = "Sicko Jumper"
        mainLabel.name = "sicko"
        mainLabel.zPosition = 1
        
        settingsButton.size = CGSize(width: 40, height: 40)
        settingsButton.position = CGPoint(x: size.width - 40, y: size.height*0.95)
        settingsButton.zPosition = 1
        settingsButton.name = "settings"
        addChild(settingsButton)
        
        
        // add the label to the scene
        addChild(normalLabel)
        addChild(AILabel)
        //addChild(highScoreLabel)
        addChild(mainLabel)
        
        // set the background
        background.size = CGSize(width: size.width, height: size.height)
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
  
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name {
            if name == "AI" {
                let scene = AIScene(size: size)
                self.view?.presentScene(scene)
                
            } else if name == "Normal" {
                let scene = NormalGameScene(size: size)
                self.view?.presentScene(scene)
            } else if name == "settings" {
                let scene = SettingsScene(size: size)
                self.view?.presentScene(scene)
            }
            
        }
        
    }
}
