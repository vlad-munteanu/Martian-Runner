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
    
    var generationTimer: Timer?
    var floorBlocks = [SKFloorBlock]()
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width, height: size.height))
        for i in 0 ..< 10 {
            
            if(i < 3) {
                let newBlock = SKFloorBlock(type: "brick")
                newBlock.position = CGPoint(x: CGFloat(i) * newBlock.size.width, y: 0)
                floorBlocks.append(newBlock)
                addChild(newBlock)
            } else {
                let newBlock = SKFloorBlock(type: floorOrWater())
                newBlock.position = CGPoint(x: CGFloat(i) * newBlock.size.width, y: 0)
                addChild(newBlock)
                floorBlocks.append(newBlock)
            }
            floorBlocks[i].moveLeft()
        }
        
    }
    
    func startGeneratingBlocks(spawnTime: TimeInterval) {
        
        generationTimer = Timer.scheduledTimer(timeInterval: spawnTime, target: self, selector: #selector(SKFloorGenerator.generateMoreBlocks), userInfo: nil, repeats: true)
        
    }
    
    @objc func generateMoreBlocks() {
        
        
        let newBlock = SKFloorBlock(type: floorOrWater())
        let temp: CGFloat = (CGFloat(floorBlocks.count + 1))
        newBlock.position = CGPoint(x: (floorBlocks.last?.position.x)! + brickWidth , y: 0)
        addChild(newBlock)
        floorBlocks.append(newBlock)
        floorBlocks.last!.moveLeft()

        floorBlocks[0].removeFromParent()
        floorBlocks.remove(at: 0)
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func floorOrWater() -> String {
        let randomNumber = Int.random(in: 0..<100)
        if(randomNumber <= (Int)(likelyhoodOfWater*100)) {
            return "water"
        }
        
        return "brick"
    }
    
    func stop() {
        generationTimer!.invalidate()
        removeAllActions()
    }
    
}
