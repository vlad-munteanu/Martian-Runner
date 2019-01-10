//
//  SKEnemyGenerator.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 1/8/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import Foundation
import SpriteKit

class SKEnemyGenerator: SKSpriteNode {
    
    var generationTimer: Timer?
    var allEnemies = [SKEnemy]()

    @objc func generateBadGuys() {
        let newEnemy = SKEnemy(post: CGPoint(x: size.width + 50 ,y: size.height*0.2))
        addChild(newEnemy)
        newEnemy.run()
        allEnemies.append(newEnemy)
    }
    
    func startGeneratingMoreEnemies(spawnTime: TimeInterval) {
        
        generationTimer = Timer.scheduledTimer(timeInterval: spawnTime, target: self, selector: #selector(SKEnemyGenerator.generateBadGuys), userInfo: nil, repeats: true)
        
    }
    
    func onCollision() {
        stopGeneratingEnemies()
        for enemy in allEnemies {
            enemy.stop()
        }
    }
    
    func stopGeneratingEnemies() {
        generationTimer!.invalidate()
    }
    
}
