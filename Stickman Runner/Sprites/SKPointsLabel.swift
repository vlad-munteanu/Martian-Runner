//
//  ⚡️⛈SKPointsLabel.swift⚡️⛈
//  ⚡️⛈Stickman Runner⚡️⛈
//
//  ⚡️⛈Created by Vlad Munteanu on 11/25/18.⚡️⛈
//  Copyright © 2018 Les Garçons. All rights reserved.
// ⚡️⛈⚡️⛈ITS FUCKING TREWAY⚡️⛈⚡️⛈

import Foundation
import UIKit
import SpriteKit

class SKPointsLabel: SKLabelNode {
    
    var number = 0
    
    init(num: Int) {
        super.init()
        
        fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        fontName = "Pixel Miners"
        fontSize = 80.0
        zPosition = 3
        
        
        number = num
        text = "\(number)"
    }
    
    func increment() {
        number += 1
        text = "\(number)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

