//
//  SkeletonBone.swift
//  BodyTracking
//
//  Created by william on 2024/6/19.
//

import Foundation
import RealityKit

struct SkeletonBone {
    var fromJoint: SkeletonJoint
    var toJoint: SkeletonJoint
    
    var centerPosition: SIMD3<Float> {
        [(fromJoint.position.x + toJoint.position.x) / 2,
         (fromJoint.position.y + toJoint.position.y) / 2,
         (fromJoint.position.z + toJoint.position.z) / 2]
    }
    
    var length: Float {
        simd_distance(fromJoint.position, toJoint.position)
    }
}
