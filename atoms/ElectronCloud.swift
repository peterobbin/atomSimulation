//
//  ElectronCloud.swift
//  atoms
//
//  Created by Luobin Wang on 7/31/15.
//  Copyright © 2015 Luobin Wang. All rights reserved.
//

import Foundation
import SpriteKit

class ElectronCloud {
    let cloud = SKNode()
    var mElctron = [Electron]()
    var numElctron = Int()
    var osciMax:CGFloat = 0.0
    
    func setup(_pos:CGPoint){
        cloud.position = _pos
        cloud.name = "cloud"
        cloud.zPosition = -2
        
        
        numElctron = Int(random(1, max: 5))
        for _ in 1...numElctron{
            mElctron.append(Electron())
        }
        
        for e in mElctron {
            let osciScale = random(50, max: 150)
            if osciMax < osciScale { osciMax = osciScale}
            cloud.addChild(e.etron)
            e.setup(CGPointZero, _osciScale: osciScale)
        }
        
        
        //cloud.addChild(mElctron.etron)
    
    }
    
    func update(){
        for e in mElctron{
            e.update()
        }
    }
    
    func random() ->CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) ->CGFloat{
        return random() * (max - min) + min
    }
}