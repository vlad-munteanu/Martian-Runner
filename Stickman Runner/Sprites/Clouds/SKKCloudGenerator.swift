//
//  ⚡️⛈SKCloudGenerator.swift⚡️⛈
//  ⚡️⛈Ninja Runner⚡️⛈
//
//  ⚡️⛈Created by Vlad Munteanu on 11/25/18.⚡️⛈
//  Copyright © 2018 Les Garçons. All rights reserved.
// ⚡️⛈⚡️⛈ITS FUCKING TREWAY⚡️⛈⚡️⛈

import Foundation
import SpriteKit

class SKCloudGenerator: SKSpriteNode {
    
    var generationTimer: Timer!
    var allClouds = [SKCloud]()
    
    func populate(num: Int) {
        for _ in 1 ... num {
            let Cloud = SKCloud()
            let CloudXPosition = CGFloat(arc4random_uniform(UInt32(size.width - CLOUD_WIDTH))) - (size.width/2 - CLOUD_WIDTH/2)
            let CloudYPosition = CGFloat(arc4random_uniform(UInt32((size.height*0.8)/2)))
            Cloud.position = CGPoint(x: CloudXPosition,y: CloudYPosition)
            addChild(Cloud)
            allClouds.append(Cloud)
        }
    }
    
    @objc func generateClouds() {
        
        let x = size.width/2 + CLOUD_WIDTH/2
        let y = CGFloat(arc4random_uniform(UInt32((size.height*0.8)/2)))
        let newCloud = SKCloud()
        newCloud.position = CGPoint(x: x,y: y)
        addChild(newCloud)
        allClouds.append(newCloud)
    }
    
    func startGeneratingMoreClouds(spawnTime: TimeInterval) {
        
        generationTimer = Timer.scheduledTimer(timeInterval: spawnTime, target: self, selector: #selector(SKCloudGenerator.generateClouds), userInfo: nil, repeats: true)
    }
    
    func onCollision() {
        stopGeneratingMoreClouds()
        
        for cloud in allClouds {
            cloud.stopMoving()
        }
    }
    
    func stopGeneratingMoreClouds() {
        generationTimer.invalidate()
    }
    
}
