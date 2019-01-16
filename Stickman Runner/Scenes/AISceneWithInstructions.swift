//
//  AISceneWithInstructions.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/9/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//


import SpriteKit
import GameplayKit

class AISceneWithInstructions: SKScene {
     let pauseLabel = SKLabelNode(fontNamed: "Pixel Miners")
    
    var pageControl:PageControl!
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        pageControl = PageControl(scene: self)
        addContent()
        pageControl.enable(numberOfPages: 4)
        addPause()
    }
    
    func addPause() {
        //pauseButton
        pauseLabel.fontSize = 16
        pauseLabel.fontColor = SKColor.black
        pauseLabel.position = CGPoint(x: size.width * 0.9, y: size.height * 0.9)
        pauseLabel.text = "Home"
        pauseLabel.name = "pause"
        
        addChild(pauseLabel)
    }
    
    private func addContent() {
        for i in 0...4 {
            let node = SKShapeNode(circleOfRadius: 10)
            node.strokeColor = .blue
            let x = self.size.width / 2.0 + self.size.width * CGFloat(i)
            let y = self.size.height / 2.0
            node.position = CGPoint(x:x, y:y)
            pageControl.addChild(node)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        if pageControl.handleTouch(touch: touch) {
            //no op
        }
        else {
            if let name = touchedNode.name {
                if name == "pause" {
                    let scene = MainMenuScene(size: size)
                    self.view?.presentScene(scene)
                }
                
            }
        }
    }
}
