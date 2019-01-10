//
//  MainMenu.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/7/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import SpriteKit

class MainMenuScene : SKScene, SKPopMenuDelegate {
    
    let normalLabel = SKLabelNode(fontNamed: "Pixel Miners")
    let AILabel = SKLabelNode(fontNamed: "Pixel Miners")
    let highScoreLabel = SKLabelNode(fontNamed: "Pixel Miners")
    let mainLabel = SKLabelNode(fontNamed: "Pixel Miners")
    var musicButton = SKSpriteNode()
    let background = SKSpriteNode(imageNamed: "bg")
    var pop: SKPopMenu!
    
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
        
        mainLabel.fontSize = 36
        mainLabel.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        mainLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.75)
        mainLabel.text = "Sicko Jumper"
        mainLabel.name = "sicko"
        mainLabel.zPosition = 1
        
        musicButton.texture = SKTexture(imageNamed: "musicOn")
        musicButton.size = CGSize(width: 40, height: 40)
        musicButton.position = CGPoint(x: size.width - 40, y: size.height*0.93)
        musicButton.zPosition = 1
        musicButton.name = "music"
        addChild(musicButton)
        
        
        // add the label to the scene
        addChild(normalLabel)
        addChild(AILabel)
        //addChild(highScoreLabel)
        addChild(mainLabel)
        
        pop = SKPopMenu(numberOfSections:2, sceneFrame: self.frame)
        let firstLabel = SKLabelNode(fontNamed: "Pixel Miners")
        let secondLabel = SKLabelNode(fontNamed: "Pixel Miners")
        firstLabel.text = "Instructions"
        firstLabel.fontSize = 15
        firstLabel.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        secondLabel.text = "Normal"
        secondLabel.fontSize = 15
        secondLabel.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       
    
        pop.setSection(1, text:"normal", color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), label: secondLabel)
        
       
        pop.setSection(2, text:"instructions", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), label: firstLabel)
        
        pop.popMenuDelegate = self
        pop.zPosition = 2
        addChild(pop)
        
        
        // set the background
        background.size = CGSize(width: size.width, height: size.height)
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
  
        addChild(background)
    }
    
    func sectionTapped(name:String) {
        if name == "instructions" {
            print("Instructions")
            pop.slideDown(0.2)
            let scene = AIScene(size: size)
            self.view?.presentScene(scene)
        } else if name == "normal" {
            print("normal")
            pop.slideDown(0.2)
            let scene = AISceneWithInstructions(size: size)
            self.view?.presentScene(scene)
        }
    }
    
    func popMenuDidAppear() {
        // pop menu appeared
    }
    
    func popMenuDidDisappear() {
        // pop menu... wait for it... disappeared 😱
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name {
            if name == "AI" {
                pop.slideUp(0.2)
                
            } else if name == "Normal" {
                let scene = NormalGameScene(size: size)
                self.view?.presentScene(scene)
            } else if name == "music" {
                print("Music changed")
                if (musicOn == true) {
                    musicButton.texture = SKTexture(imageNamed: "musicOff")
                    musicOn = false
                } else if musicOn == false {
                    musicButton.texture = SKTexture(imageNamed: "musicOn")
                    musicOn = true
                }
            }
            
        }
        
    }
}
