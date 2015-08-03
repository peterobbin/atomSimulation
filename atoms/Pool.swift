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
        cosmos.name = "cosmos"
   

    }
    
    func getTouch(touchLoc:CGPoint, _creatNew:Bool){
        let location = touchLoc
        if _creatNew{
            mAtoms.append(Atom(_initPoint: location))
        }
       
        
    }
    
    
    func update(){
        for a in mAtoms{
            //  do the setup for an atom
            if a.notConfigured{
               cosmos.addChild(a.atom)
               a.setup(false)
            }
            a.update()
            
        
        }
        
        
        if mAtoms.count > 10 {
            mAtoms[0].atom.removeFromParent()
            mAtoms.removeAtIndex(0)
            
        }
        
    
    }
}