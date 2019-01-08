//
//  ⚡️⛈GKCloud.swift⚡️⛈
//  ⚡️⛈Ninja Runner⚡️⛈
//
//  ⚡️⛈Created by Vlad Munteanu on 11/25/18.⚡️⛈
//  Copyright © 2018 Les Garçons. All rights reserved.


import Foundation
import SpriteKit

class SKCloud: SKSpriteNode {
    
    init() {
        super.init(texture: SKTexture(image: #imageLiteral(resourceName: "cloud")), color: UIColor.clear, size: CGSize(width: CLOUD_WIDTH,height: CLOUD_HEIGHT))
        self.zPosition = 0
       
        
        startMoving()
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveBy(x: -10, y: 0, duration: 1)
        run(SKAction.repeatForever(moveLeft))
    }
    
    func stopMoving() {
        removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
