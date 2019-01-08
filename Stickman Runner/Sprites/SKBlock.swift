//
//  SKBlock.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/8/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import Foundation
import SpriteKit

class SKBlock: SKSpriteNode {
    init() {
     super.init(texture: SKTexture(image: #imageLiteral(resourceName: "block")), color: UIColor.clear, size: CGSize(width: brickWidth,height: brickHeight))
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = blockCategory
        physicsBody?.collisionBitMask = stickManCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        //idk if this is necessary 
        physicsBody?.friction = 0.2
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
