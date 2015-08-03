//
//  Nuclei.swift
//  atoms
//
//  Created by Luobin Wang on 7/31/15.
//  Copyright © 2015 Luobin Wang. All rights reserved.
//

import Foundation
import SpriteKit

class Nuclei {
    let centerNuclei = SKSpriteNode(imageNamed: "nuclei")
    
    func setup(_pos:CGPoint){
        centerNuclei.position = _pos
  
    }
}
