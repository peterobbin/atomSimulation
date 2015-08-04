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
        self.addChild(pool.metaballEffect)
        pool.setup()
        pool.metaballEffect.zPosition = -3
        self.backgroundColor = SKColor.blackColor()
        self.physicsWorld.gravity = CGVectorMake(0, 0)
    
    
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            print(touchedNode)
           
//            if self.frame.contains(location) && touchedNode.name == "atom"{
//                touchedNode.position = location
//            }
            
            if touchedNode.name == nil{
                pool.getTouch(location, _creatNew: true)
            }else{
                pool.getTouch(location, _creatNew: false)

            }
            
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            if self.frame.contains(location) && touchedNode.name == "atom"{
                
                let vel = CGVector(dx: (location.x - touchedNode.position.x) * 5.0, dy: (location.y - touchedNode.position.y) * 5.0 )
                touchedNode.physicsBody?.velocity = vel
            }
            

            
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        pool.update()
    }
}
