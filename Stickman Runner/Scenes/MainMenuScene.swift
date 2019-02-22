//
//  MainMenu.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/7/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import SpriteKit

class MainMenuScene : SKScene, Alertable {
    
    let playLabel = SKLabelNode()
    let highScoreLabel = SKLabelNode(fontNamed: "Pixel Miners")
    
    let instructionLabel = SKLabelNode()
    let mainLabel = SKSpriteNode(imageNamed: "Martian-Runner")
    var musicButton = SKSpriteNode()
    let background = SKSpriteNode(imageNamed: "bg")
    
    override func didMove(to view: SKView) {
    
        // set size, color, position and text of the tapStartLabel
        playLabel.fontSize = 42
        playLabel.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        playLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.32)
        playLabel.text = "Play Game"
        playLabel.name = "play"
        playLabel.zPosition = 1
        
        highScoreLabel.fontSize = 15
        highScoreLabel.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        highScoreLabel.position = CGPoint(x: size.width * 0.26 , y: size.height * 0.015 )
        
        if (UserDefaults.standard.integer(forKey: "highscore")) != nil {
            highScoreLabel.text = "High Score: \(UserDefaults.standard.integer(forKey: "highscore"))"
        } else {
            highScoreLabel.text = "High Score: 0"
        }
        
        highScoreLabel.zPosition = 1
        
        mainLabel.size = CGSize(width: size.width , height: 60)
        mainLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.75 )
        mainLabel.name = "sicko"
        mainLabel.zPosition = 1
        
        musicButton.texture = SKTexture(imageNamed: "musicOff")
        musicButton.size = CGSize(width: 40, height: 40)
        musicButton.position = CGPoint(x: size.width - 40, y: size.height*0.93)
        musicButton.zPosition = 1
        musicButton.name = "music"
        //addChild(musicButton)
        
        
        // add the label to the scene
        addChild(playLabel)
       
        addChild(highScoreLabel)
        addChild(mainLabel)
        
        // set the background
        background.size = CGSize(width: size.width, height: size.height)
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        addChild(background)
    }
    
    //TO-DO: Fix transitions to new scenes
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name {
            if name == "choose" {
//                let scene = ChooseNetwork(size: size)
//                self.view?.presentScene(scene)
            } else if name == "music" {
                print("Music changed")
                if (musicOn == true) {
                    musicButton.texture = SKTexture(imageNamed: "musicOff")
                    musicOn = false
                } else if musicOn == false {
                    musicButton.texture = SKTexture(imageNamed: "musicOn")
                    musicOn = true
                }
            } else if name == "learn" {
//                let scene = AISceneWithInstructions(size: size)
//                self.view?.presentScene(scene)
            }
            
        }
        
    }
}
