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
    
    var allEnemies = [SKEnemy]()
    var enemyTime: TimeInterval = 1.1
    var exponent = 1.0
    
    func generateBadGuys() {
        
        for i in 0...3 {
            var addNum: CGFloat = 100
            if(allEnemies.count > 0 ) {
                var calc = (Int)((pow(400,exponent)))
            
                addNum = (allEnemies.last?.position.x)! + CGFloat(Int.random(in: calc...1800))
            }
            
            let newEnemy = SKEnemy(post: CGPoint(x: size.width * 2 + addNum ,y: size.height*0.2), time: enemyTime)
            addChild(newEnemy)
            newEnemy.run()
            allEnemies.append(newEnemy)
        }
    }
    
    func calcTime() {
        if(enemyTime >= 0.5) {
            enemyTime -= 0.15
            if exponent < 1.22{
                exponent += 0.02
            }
        }
    }
    

    
    func onCollision() {
        stopGeneratingEnemies()
        for enemy in allEnemies {
            enemy.removeFromParent()
        }
    }
    
    func stop(){
       removeAllActions()
    }
    
    func restart() {
        onCollision()
        allEnemies.removeAll()
        calcTime()
        generateBadGuys()
    }
    
   
    
    func stopGeneratingEnemies() {
      
    }
    
}
