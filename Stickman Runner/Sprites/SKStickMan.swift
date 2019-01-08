//
//  SKStickMan.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/7/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import Foundation
import SpriteKit

class SKStickMan: SKSpriteNode {
    
    init() {
        
        super.init(texture: SKTexture(imageNamed: "man-stand"), color: UIColor.clear, size: CGSize(width: 70,height: 70))
        
        loadPhysicsBodyWithSize(size: CGSize(width: 70,height: 70))
    }
    
    func run() {
        
        var coinManRun : [SKTexture] = []
        for number in 1...3
        {
            coinManRun.append(SKTexture(imageNamed: "man-run\(number)"))
        }
        
       self.run(SKAction.repeatForever(SKAction.animate(with: coinManRun, timePerFrame: 0.1)))
    }
    
    func jump(){
        self.texture = SKTexture(imageNamed: "man-run1")
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = stickManCategory
        physicsBody?.contactTestBitMask = waterAndSpikeCategory
        physicsBody?.collisionBitMask = brickCategory
        physicsBody?.affectedByGravity = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
