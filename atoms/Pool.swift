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
    let metaballEffect = SKEffectNode()
    let fragShader = SKShader(fileNamed: "metaball")
    var mAtoms = [Atom]()
    var mBalls = [Uncertainty]()
    
    
    
    
    func setup(){
        cosmos.position = CGPointZero
        //cosmos.name = "cosmos"
    
        print(metaballEffect.position)
        metaballEffect.position = cosmos.position
        metaballEffect.shader = fragShader
        //metaballEffect.name = "metaball"

   

    }
    
    func getTouch(touchLoc:CGPoint, _creatNew:Bool){
        let location = touchLoc
        if _creatNew{
            mAtoms.append(Atom(_initPoint: location))
            mBalls.append(Uncertainty(_initPoint: location))
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
        
        for b in mBalls{
            if b.notConfigured{
                metaballEffect.addChild(b.uncertainCloud)
                b.setup(false)
            }
        }
        
        //print(metaballEffect.children.count)
        
        for (var i:Int = 0 ; i < mBalls.count; i++){
            metaballEffect.children[i].position = mAtoms[i].atom.position
        }
        
        
        if mAtoms.count > 10 {
            mAtoms[0].atom.removeFromParent()
            mBalls[0].uncertainCloud.removeFromParent()
            mAtoms.removeAtIndex(0)
            mBalls.removeAtIndex(0)
            
            
        }
        
    
    }
}