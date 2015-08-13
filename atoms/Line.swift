//
//  Line.swift
//  atoms
//
//  Created by Luobin Wang on 8/12/15.
//  Copyright © 2015 Luobin Wang. All rights reserved.
//

import Foundation
import SpriteKit

class Line {
    var connectedLine = SKShapeNode()
    var configured = false
    var nucleiPosA = CGPoint()
    var nucleiPosB = CGPoint()
    
    
    func setup(){
       connectedLine.name = "line"
    }
    
    func update(_nucleiPosA:CGPoint, _nucleiPosB:CGPoint){
        self.nucleiPosA = _nucleiPosA
        self.nucleiPosB = _nucleiPosB
        
        let pathToDraw = CGPathCreateMutable()
        CGPathMoveToPoint(pathToDraw, nil, nucleiPosA.x, nucleiPosA.y)
        CGPathAddLineToPoint(pathToDraw, nil, nucleiPosB.x, nucleiPosB.y)

    
        connectedLine.path = pathToDraw
        connectedLine.lineWidth = 10.0
        connectedLine.strokeColor = UIColor.whiteColor()
        
       // print("a is \(_nucleiPosA) b is \(_nucleiPosB)")
       
    
    }
}
