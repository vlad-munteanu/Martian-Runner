//
//  FloorGenerator.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/7/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import Foundation
import SpriteKit

class SKFloorGenerator: SKSpriteNode {
    
   
    var floorBlocks = [SKFloorBlock]()
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width, height: size.height))
        //anchorPoint = CGPoint(x: 0, y: 0)
        for i in 0 ..< 50 {
            let newBlock = SKFloorBlock(type: floorOrWater())
            newBlock.position = CGPoint(x: CGFloat(i) * newBlock.size.width, y: 0)
            addChild(newBlock)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func startMoving() {
        
        let setDurationTime: TimeInterval = TimeInterval(frame.size.width/2/floorXtoMovePerSec)
        //moves floor left
        let moveGroundLeft = SKAction.moveBy(x: -frame.size.width/2, y: 0, duration: setDurationTime)
        //moves ground back to intial position
        let resetPosition = SKAction.moveBy(x: frame.size.width/2, y: 0, duration: 0)
        //creates sequence
        let floorSequence = SKAction.sequence([moveGroundLeft,resetPosition])
        run(SKAction.repeatForever(floorSequence))
    }
    
    func floorOrWater() -> String {
        let randomNumber = Int.random(in: 0..<100)
        if(randomNumber <= (Int)(likelyhoodOfWater*100)) {
            return "water"
        }
        
        return "brick"
    }
    
    func stop() {
        removeAllActions()
    }
    
}
