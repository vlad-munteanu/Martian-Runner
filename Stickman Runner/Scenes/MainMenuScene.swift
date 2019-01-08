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
    override func didMove(to view: SKView) {
        // set the background
        backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        // set size, color, position and text of the tapStartLabel
        normalLabel.fontSize = 24
        normalLabel.fontColor = SKColor.black
        normalLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.8)
        normalLabel.text = "Normal Mode"
        normalLabel.name = "Normal"
        
        
        // set size, color, position and text of the tapStartLabel
        AILabel.fontSize = 24
        AILabel.fontColor = SKColor.black
        AILabel.position = CGPoint(x: size.width / 2, y: size.height * 0.6 )
        AILabel.text = "AI Mode"
        AILabel.name = "AI"
        
        
        
        // add the label to the scene
        addChild(normalLabel)
        addChild(AILabel)
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
            }
            
        }
        
    }
}
