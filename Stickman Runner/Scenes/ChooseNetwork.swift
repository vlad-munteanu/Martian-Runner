//
//  ChooseNetwork.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/16/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//  This scene allows for users to select differnet neural networks

import Foundation
import SpriteKit

class ChooseNetwork : SKScene {
    var setOfLabels = [SKLabelNode(fontNamed: "Pixel Miners")]
     let pauseLabel = SKLabelNode(fontNamed: "Pixel Miners")
    
    override func didMove(to view: SKView) {
        
        addIntialLabels()
       
    }
    
    func addIntialLabels() {
        setOfLabels[0].position = CGPoint(x: size.width / 2, y: size.height * 0.85)
        setOfLabels[0].text = "Choose a Neural Network"
        setOfLabels[0].fontSize = 15
        addChild(setOfLabels[0])
        
        var xPosVar: CGFloat = 0.79
        var counter = 0
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            if let temp = value as? [Float] {
                print("\(key) = \(value) \n")
                setOfLabels.append(SKLabelNode(text: key))
                setOfLabels.last!.name = key
                setOfLabels.last!.fontSize = 50
                setOfLabels.last!.fontColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                setOfLabels.last!.position = CGPoint(x: size.width / 2, y: size.height * xPosVar)
                addChild(setOfLabels.last!)
                counter += 1
                xPosVar -= 0.1
            }
        }
        
        if(counter == 0) {
            setOfLabels.append(SKLabelNode(text: "No networks found!"))
            setOfLabels.last!.name = "no network"
            setOfLabels.last!.fontSize = 30
            setOfLabels.last!.horizontalAlignmentMode = .left
            setOfLabels.last!.fontColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            setOfLabels.last!.position = CGPoint(x: size.width / 4, y: size.height * xPosVar)
            addChild(setOfLabels.last!)
        }
        
        //pauseButton
        pauseLabel.fontSize = 12
        pauseLabel.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pauseLabel.position = CGPoint(x: size.width * 0.9, y: size.height * 0.93)
        pauseLabel.text = "Home"
        pauseLabel.name = "pause"
        
        addChild(pauseLabel)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //change to AIScene
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name {
            if name == "pause" {
                let scene = MainMenuScene(size: size)
                self.view?.presentScene(scene)
            } else {
            currentName = name
            let scene = AIScene(size: size)
            self.view?.presentScene(scene)
            }
        }
        
    }
}
