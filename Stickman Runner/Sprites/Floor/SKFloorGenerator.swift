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
        anchorPoint = CGPoint(x:-size.width, y:0)
        
        for i in 0 ..< 100 {
            
            let newBlock = SKFloorBlock(type: "brick")
            newBlock.position = CGPoint(x: CGFloat(i) * newBlock.size.width, y: 0)
            addChild(newBlock)
            floorBlocks.append(newBlock)
            
            
        }
        
    }
    
    
    func start() {
        
        var adjustedDuration: TimeInterval 
        {
            get {
                return TimeInterval(size.width/xPerSec)
            }
        }
       
        //Moves ground left by one whole screen
        var moveLeft = SKAction.moveBy(x: -(size.width)*2, y: 0, duration: adjustedDuration)
        
        //Teleports ground back to initial position
        let resetPosition = SKAction.moveTo(x: -size.width , duration: 0)
        
        
        //Creates a sequence that combines above to actions
        let mySequence = SKAction.sequence([moveLeft,resetPosition])
        
        //Runs the sequence forever
        run(SKAction.repeatForever(mySequence))
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func stop() {
        //generationTimer!.invalidate()
        removeAllActions()
    }
    
}
