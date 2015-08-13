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
    let cosmos = SKSpriteNode()
    let lines = SKEffectNode()
    let metaballEffect = SKEffectNode()
    let fragShader = SKShader(fileNamed: "metaball")
    let fragShader2 = SKShader(fileNamed: "blur")
    var mAtoms = [Atom]()
    var mBalls = [Uncertainty]()
    var lastA = Atom(_initPoint: CGPointZero)
    var distArray = [CGFloat]()
    var lineArray = [Line]()
    var atomA = [Atom]()
    var atomB = [Atom]()
    
    var joints = [SKPhysicsJoint]()
    
    

    
    func setup(){
        cosmos.position = CGPointZero
        //lines.position = cosmos.position
        //cosmos.name = "cosmos"
    
        //print(metaballEffect.position)
        metaballEffect.position = cosmos.position
        metaballEffect.shader = fragShader
        lines.shader = fragShader2
        lines.zPosition = -4
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
        joints.append(joint)
    }
    
    func removeSpringJoint(_atomsBody:SKPhysicsBody, _selfWorld:SKPhysicsWorld){
        for j in joints {
            if j.bodyA == _atomsBody || j.bodyB == _atomsBody {
                _selfWorld.removeJoint(j)
            }
        }
    }
    
    func removeLine(endingPos:CGPoint){
    
        for l in lineArray{
            if l.nucleiPosA == endingPos || l.nucleiPosB == endingPos {
                l.connectedLine.removeFromParent()
            }
        }
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
        
        //  create array of distances
        distArray.removeAll()
        for (var i:Int = 0; i < mAtoms.count - 1; i++){
            distArray.append(CGFloat())
        }
        
        //  calculate distance and store it
        if mAtoms.last != nil{
            for (var i:Int = 0; i < distArray.count; i++){
                let dist = hypot((mAtoms.last?.atom.position.x)! - mAtoms[i].atom.position.x, (mAtoms.last?.atom.position.y)! - mAtoms[i].atom.position.y)
                if dist != 0{
                distArray[i] = dist
                //print(dist)
                }
            }
        }
        var minValue = CGFloat()
        var minIndex = Int()
        var secondMinValue = CGFloat()
        var secondMinIndex = Int()

        
        // get the mininum dist element and the second mininum, also their index
        if distArray.count > 0{
            minValue = 1500.0
            secondMinValue = 1500.0
            
            for i in 0..<distArray.count {
               
                if distArray[i] < minValue {
                    minValue = distArray[i]
                    minIndex = i
                }

            }
      
            //print(minIndex)
            
            for i in 0..<distArray.count {
                if distArray[i] < secondMinValue && i != minIndex{
                    secondMinValue = distArray[i]
                    secondMinIndex = i
                }
            }
   
            
            //print("the max index is \(minIndex) and value is \(minValue), second max index is \(secondMinIndex) and value is \(secondMinValue)")
        }
        
        
        
        
 
        // add joint in here
        if mAtoms.last != nil && lastA.atom.position != CGPointZero && lastA.atom != mAtoms.last?.atom{
        
            addSpringJoint(mAtoms[minIndex].atom.physicsBody!, _atomsBodyB: (mAtoms.last?.atom.physicsBody)!, _atomsPosA: mAtoms[minIndex].atom.position, _atomsPosB: mAtoms.last!.atom.position, _selfWorld: _selfWorld)
            //print("aPos is \(mAtoms[minIndex].atom.position) bPos is \(mAtoms.last?.atom.position)")
            lineArray.append(Line())
            atomA.append(mAtoms[minIndex])
            atomB.append(mAtoms.last!)
            

            if mAtoms.count > 2{
                addSpringJoint(mAtoms[secondMinIndex].atom.physicsBody!, _atomsBodyB: (mAtoms.last?.atom.physicsBody)!, _atomsPosA: mAtoms[secondMinIndex].atom.position, _atomsPosB: mAtoms.last!.atom.position, _selfWorld: _selfWorld)
                lineArray.append(Line())
                atomA.append(mAtoms[secondMinIndex])
                atomB.append(mAtoms.last!)
            }
            
        }
        if mAtoms.last != nil{
            lastA = mAtoms.last!
        }
        
     
        
        for i in 0..<lineArray.count{
            if lineArray[i].configured == false{
                lineArray[i].configured = true
                lineArray[i].setup()
                lines.addChild(lineArray[i].connectedLine)
            }
            lineArray[i].update(atomA[i].atom.position, _nucleiPosB: atomB[i].atom.position)
            //print("the \(i+1) line A point position is \(atomA[i].atom.position)")
        }
        
        
        
         //print(lines.children.count)
        

        
        // add the mystic clouds
        for b in mBalls{
            if b.notConfigured{
                metaballEffect.addChild(b.uncertainCloud)
                b.setup(false)
            }
        }

        // sync the mystic clouds position
        for (var i:Int = 0 ; i < mBalls.count; i++){
            metaballEffect.children[i].position = mAtoms[i].atom.position
            metaballEffect.children[i].xScale = mAtoms[i].cloudScale
            metaballEffect.children[i].yScale = mAtoms[i].cloudScale
        }
        
        // kill the first one in the array if the number reaches 10
        if mAtoms.count > 10 {
            removeLine(mAtoms[0].atom.position)
            removeSpringJoint(mAtoms[0].atom.physicsBody!, _selfWorld: _selfWorld)
            mAtoms[0].atom.removeFromParent()
            mBalls[0].uncertainCloud.removeFromParent()
            mAtoms.removeAtIndex(0)
            mBalls.removeAtIndex(0)
            
            
        }
        
    
    }
}