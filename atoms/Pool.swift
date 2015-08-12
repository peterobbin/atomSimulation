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
    var lastA = Atom(_initPoint: CGPointZero)
    var distArray = [CGFloat]()

    
    func setup(){
        cosmos.position = CGPointZero
        //cosmos.name = "cosmos"
    
        //print(metaballEffect.position)
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
    
    func addSpringJoint(_atomsBodyA:SKPhysicsBody, _atomsBodyB:SKPhysicsBody, _atomsPosA:CGPoint, _atomsPosB:CGPoint, _selfWorld:SKPhysicsWorld){
        let joint = SKPhysicsJointSpring.jointWithBodyA(_atomsBodyA, bodyB: _atomsBodyB, anchorA: _atomsPosA, anchorB: _atomsPosB)
        joint.frequency = 10.0
        _selfWorld.addJoint(joint)
    }
    
    
    func update(_selfWorld:SKPhysicsWorld, _windowSize:CGSize){
        for a in mAtoms{
            
            //  do the setup for an atom
            if a.notConfigured{
               cosmos.addChild(a.atom)
               a.setup(false)
            }
            a.update()
 
        }
        
        distArray.removeAll()
        for (var i:Int = 0; i < mAtoms.count; i++){
            distArray.append(CGFloat())
        }
        
        
        if mAtoms.last != nil{
            for (var i:Int = 0; i < mAtoms.count - 1; i++){
                let dist = hypot(lastA.atom.position.x - mAtoms[i].atom.position.x, lastA.atom.position.y - mAtoms[i].atom.position.y)
                distArray[i] = dist
                //print(dist)
            }
        }
        var minValue = CGFloat()
        var minIndex = Int()
        var secondMinValue:CGFloat = CGFloat()
        var secondMinIndex = Int()
        
        if distArray.count > 0{
            minValue = distArray[0]
            secondMinValue = 1500.0
            
            for i in 0..<distArray.count - 1 {
                if distArray[i] < minValue {
                    minValue = distArray[i]
                    minIndex = i
                }
            }
            
            for i in 0..<distArray.count - 1 {
                if distArray[i] < secondMinValue && i != minIndex{
                    secondMinValue = distArray[i]
                    secondMinIndex = i
                }
            }
            
            
            print("the max index is \(minIndex) and value is \(minValue), second max index is \(secondMinIndex) and value is \(secondMinValue)")
        }
        
 
        // add joint in here
        
        if mAtoms.last != nil && lastA.atom.position != CGPointZero && lastA.atom != mAtoms.last?.atom{
        
            addSpringJoint(mAtoms[minIndex].atom.physicsBody!, _atomsBodyB: (mAtoms.last?.atom.physicsBody)!, _atomsPosA: mAtoms[minIndex].atom.position, _atomsPosB: mAtoms.last!.atom.position, _selfWorld: _selfWorld)
            
            if mAtoms.count > 2{
                addSpringJoint(mAtoms[secondMinIndex].atom.physicsBody!, _atomsBodyB: (mAtoms.last?.atom.physicsBody)!, _atomsPosA: mAtoms[secondMinIndex].atom.position, _atomsPosB: mAtoms.last!.atom.position, _selfWorld: _selfWorld)
            }
            
        }
        if mAtoms.last != nil{
            lastA = mAtoms.last!
        }
        
        
        for b in mBalls{
            if b.notConfigured{
                metaballEffect.addChild(b.uncertainCloud)
                b.setup(false)
            }
        }

        
        for (var i:Int = 0 ; i < mBalls.count; i++){
            metaballEffect.children[i].position = mAtoms[i].atom.position
            metaballEffect.children[i].xScale = mAtoms[i].cloudScale
            metaballEffect.children[i].yScale = mAtoms[i].cloudScale
        }
        
        
        if mAtoms.count > 10 {
            mAtoms[0].atom.removeFromParent()
            mBalls[0].uncertainCloud.removeFromParent()
            mAtoms.removeAtIndex(0)
            mBalls.removeAtIndex(0)
            
            
        }
        
    
    }
}