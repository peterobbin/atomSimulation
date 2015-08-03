//
//  Pool.swift
//  atoms
//
//  Created by Luobin Wang on 7/31/15.
//  Copyright © 2015 Luobin Wang. All rights reserved.
//

import Foundation
import SpriteKit

class Pool {
    let cosmos = SKNode()
    var mAtoms = [Atom]()
    
    
    
    func setup(){
        cosmos.position = CGPointZero
   

    }
    
    func getTouch(touchLoc:CGPoint){
        let location = touchLoc
        mAtoms.append(Atom(_initPoint: location))
       
        
    }
    
    func update(){
        for a in mAtoms{
            if a.notConfigured{
               cosmos.addChild(a.atom)
               a.setup(false)
            }
            print(a.atom.children.count)
            a.update()
        }
        
    
    }
}