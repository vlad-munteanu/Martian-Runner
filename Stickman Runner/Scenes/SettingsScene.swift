//
//  SettingsScene.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/9/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import SpriteKit

class SettingsScene: SKScene {
    override func didMove(to view: SKView) {
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
