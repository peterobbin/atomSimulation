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
    func setup(_pos:CGPoint){
        uncertainCloud.position = _pos
        uncertainCloud.name = "uncertainCloud"
        uncertainCloud.zPosition = -3
    }

    func update(){
    
    }
    
}
