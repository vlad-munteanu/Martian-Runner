//
//  SKEnemy.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/8/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//


import Foundation
import SpriteKit

class SKEnemy: SKSpriteNode {
    
    init(post: CGPoint) {
        
        super.init(texture: SKTexture(imageNamed: "slime1"), color: UIColor.clear, size: CGSize(width: 30,height: 40))
        self.zPosition = 1
        self.position = post
        loadPhysicsBodyWithSize(size: CGSize(width: 30,height: 40))
    }
    
    func run() {
        
        var slimey : [SKTexture] = []
        for number in 1...2
        {
            slimey.append(SKTexture(imageNamed: "slime\(number)"))
        }
        
        self.run(SKAction.repeatForever(SKAction.animate(with: slimey, timePerFrame: 0.1)))
        
        var moveLeft = SKAction.moveBy(x: CGFloat(-enemySpeed), y: 0, duration: 0.8)
        
        self.run(SKAction.repeatForever(moveLeft))
    }
    
    func stop(){
        self.removeAllActions()
    }
    
    
    
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = badGuyCategory
        physicsBody?.contactTestBitMask = stickManCategory
        physicsBody?.collisionBitMask = brickCategory
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
