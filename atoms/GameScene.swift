//
//  GameScene.swift
//  atoms
//
//  Created by Luobin Wang on 7/31/15.
//  Copyright (c) 2015 Luobin Wang. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let pool = Pool()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.addChild(pool.cosmos)
        self.backgroundColor = SKColor.blackColor()
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch in touches {
            let location = touch.locationInNode(self)
    
            pool.getTouch(location)
            
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        pool.update()
    }
}
