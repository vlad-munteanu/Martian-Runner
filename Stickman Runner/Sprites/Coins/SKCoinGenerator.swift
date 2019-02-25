//
//  SKCoinGenerator.swift
//  Stickman Runner
//
//  Created by Vlad Munteanu on 2/24/19.
//  Copyright © 2019 LesGarcons. All rights reserved.
//

import Foundation
import SpriteKit

class SKCoinGenerator: SKSpriteNode {
    
    func onCollision() {
        
    }
    
    func stop() {
        removeAllActions()
    }
    
    func restart() {
        onCollision()
    }
}
