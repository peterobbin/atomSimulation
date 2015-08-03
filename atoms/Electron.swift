//
//  Electron.swift
//  atoms
//
//  Created by Luobin Wang on 7/31/15.
//  Copyright © 2015 Luobin Wang. All rights reserved.
//

import Foundation
import SpriteKit

class Electron {
    let etron = SKSpriteNode(imageNamed: "electron")
    var pos = CGPointZero
    var osciScale = CGFloat()
    var timeOffset = CGFloat()
    var orbitSpeed = CGFloat()
    var clockWise = Bool()
    func setup(_pos:CGPoint, _osciScale:CGFloat){
        self.pos = _pos
        self.osciScale = _osciScale
        let decideOrbitOrient = random(0, max: 1)
        if decideOrbitOrient > 0.5 {
            clockWise = true
        }else{
            clockWise = false
        }
        timeOffset = CGFloat(random(0, max: CGFloat(M_PI * 2)))
        orbitSpeed = CGFloat(random(0, max: 10))
        etron.name = "electron"
        etron.position = pos
    }
    
    func update(){
        
        let time = CGFloat(CFAbsoluteTimeGetCurrent()) * orbitSpeed + timeOffset
        let xOsci = CGFloat(sin(time)) * osciScale
        let yOsci = CGFloat(cos(time)) * osciScale
        if clockWise {
            etron.position = CGPoint(x: pos.x + xOsci, y: pos.y + yOsci)
        }else{
            etron.position = CGPoint(x: pos.x + yOsci, y: pos.y + xOsci)
        }
    }
    
    func random() ->CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) ->CGFloat{
        return random() * (max - min) + min
    }
}