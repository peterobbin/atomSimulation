//
//  Atom.swift
//  atoms
//
//  Created by Luobin Wang on 7/31/15.
//  Copyright © 2015 Luobin Wang. All rights reserved.
//

import Foundation
import SpriteKit

class Atom {
    let atom = SKNode()
    let mNuclei = Nuclei()
    let mCloud = ElectronCloud()
    //let mUncertaintyCloud = Uncertainty()
    var initPoint:CGPoint
    var notConfigured = true
    var scale:CGFloat = 0.5
    var cloudScale = CGFloat()
    
    init(_initPoint:CGPoint){
        self.initPoint = _initPoint
    }
   
    func setup(_notConfigured:Bool){
        self.notConfigured = _notConfigured
        atom.addChild(mNuclei.centerNuclei)
        atom.addChild(mCloud.cloud)
        //atom.addChild(mUncertaintyCloud.uncertainCloud)
        mNuclei.setup(CGPointZero)
        mCloud.setup(CGPointZero)
       // mUncertaintyCloud.setup(CGPointZero)
        atom.name = "atom"
        atom.zPosition = 2
        atom.position = initPoint
        atom.xScale = scale
        atom.yScale = atom.xScale
        atom.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        atom.physicsBody?.linearDamping = 0.5
        atom.physicsBody?.mass = 500
    }

    func update(){
        mCloud.update()
        cloudScale = mCloud.osciMax * 0.007
    }
    
   

}