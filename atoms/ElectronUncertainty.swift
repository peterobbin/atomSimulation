//
//  ElectronUncertainty.swift
//  atoms
//
//  Created by Luobin Wang on 8/3/15.
//  Copyright © 2015 Luobin Wang. All rights reserved.
//

import Foundation
import SpriteKit

class Uncertainty {
    let uncertainCloud = SKSpriteNode(imageNamed: "glow.png")
    let initPoint:CGPoint
    var notConfigured = true
    
    init(_initPoint:CGPoint){
        self.initPoint = _initPoint
        self.uncertainCloud.position = initPoint
    }
    
    func setup(_notConfigured:Bool){
        self.notConfigured = _notConfigured
        //uncertainCloud.position = _pos
        uncertainCloud.name = "uncertainCloud"
        uncertainCloud.zPosition = -3
    }

    func update(){
        
    }
    
}
