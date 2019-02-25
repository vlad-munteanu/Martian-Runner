//
//  SKCoin.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 2/24/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import Foundation
import SpriteKit

class SKCoin: SKSpriteNode {
    init() {
          super.init(texture: SKTexture(imageNamed: "slime1"), color: UIColor.clear, size: CGSize(width: 30,height: 40))
        loadPhysicsBodyWithSize(size: CGSize(width: 30,height: 40))
    }
    
    func stop(){
        self.removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = coinCategory
        physicsBody?.contactTestBitMask = stickManCategory
        physicsBody?.collisionBitMask = brickCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
    }

    
}
