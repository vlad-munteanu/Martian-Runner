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
    
    var category = brickCategory
    var amWater = false
    init(type: String)
    {
        super.init(texture: SKTexture(imageNamed: type), color: UIColor.clear, size: CGSize(width: brickWidth,height: brickHeight))
        if(type == "water") {
            category = waterAndSpikeCategory
            self.size = CGSize(width: brickWidth,height: brickHeight/2)
            loadPhysicsBodyWithSize(size: CGSize(width: brickWidth,height: brickHeight/2))
            amWater = true
        } else {
            //Creating the physics body
            loadPhysicsBodyWithSize(size: CGSize(width: brickWidth,height: brickHeight))
        }
    }
    
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = category
        physicsBody?.collisionBitMask = stickManCategory
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0.2
    }
    
//    func setCat(catty: String) {
//        category = waterAndSpikeCategory
//        self.size = CGSize(width: brickWidth,height: brickHeight/2)
//        loadPhysicsBodyWithSize(size: CGSize(width: brickWidth,height: brickHeight/2))
//        amWater = true
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
