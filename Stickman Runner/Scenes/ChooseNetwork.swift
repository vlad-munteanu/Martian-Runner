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
    
    
    override func didMove(to view: SKView) {
        addIntialLabels()
       
    }
    
    func addIntialLabels() {
        setOfLabels[0].position = CGPoint(x: size.width / 2, y: size.height * 0.9)
        setOfLabels[0].text = "Choose a Neural Network"
        setOfLabels[0].fontSize = 15
        addChild(setOfLabels[0])
        
        var xPosVar: CGFloat = 0.8
        var counter = 0
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            
            if let temp = value as? [Float] {
                print("\(key) = \(value) \n")
                setOfLabels.append(SKLabelNode(text: key))
                setOfLabels.last!.name = key
                setOfLabels.last!.fontSize = 40
                setOfLabels.last!.horizontalAlignmentMode = .left
                setOfLabels.last!.fontColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                setOfLabels.last!.position = CGPoint(x: size.width / 4, y: size.height * xPosVar)
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
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //change to AIScene
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if let name = touchedNode.name {
           
            currentName = name
            let scene = AIScene(size: size)
            self.view?.presentScene(scene)
            
        }
        
    }
}
