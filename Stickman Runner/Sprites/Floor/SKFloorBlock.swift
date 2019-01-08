//
//  SKWaterBlock.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/7/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import Foundation
import SpriteKit

class SKFloorBlock: SKSpriteNode {
    
  
    init(type: String)
    {
        super.init(texture: SKTexture(imageNamed: type), color: UIColor.clear, size: CGSize(width: brickWidth,height: brickHeight))
            //Creating the physics body
            loadPhysicsBodyWithSize(size: CGSize(width: brickWidth,height: brickHeight))
    }
    
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = brickCategory
        physicsBody?.collisionBitMask = stickManCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0.2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
