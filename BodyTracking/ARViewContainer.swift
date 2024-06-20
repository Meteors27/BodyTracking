//
//  ARViewContainer.swift
//  BodyTracking
//
//  Created by william on 2024/6/19.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

private var bodySkeleton: BodySkeleton?
private let bodySkeletonAnchor = AnchorEntity()

private var characterEntity: BodyTrackedEntity?
private let characterOffset: SIMD3<Float> = [-1, 0, 0] // Offset the character by one meter to the left

struct ARViewContainer: UIViewRepresentable {
    
    @State private var arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
    func makeUIView(context: Context) -> ARView {
        arView.setupForBodyTracking()
        arView.scene.addAnchor(bodySkeletonAnchor)
        
        // Asynchronously load the 3D character.
        var cancellable: AnyCancellable? = nil
        cancellable = Entity.loadBodyTrackedAsync(named: "character/robot").sink(
            receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: Unable to load model: \(error.localizedDescription)")
                }
                cancellable?.cancel()
        }, receiveValue: { (character: Entity) in
            if let character = character as? BodyTrackedEntity {
                // Scale the character to human size
                character.scale = [1.0, 1.0, 1.0]
                characterEntity = character
                cancellable?.cancel()
            } else {
                print("Error: Unable to load model as BodyTrackedEntity")
            }
        })
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
    
    static func dismantleUIView(_ uiView: ARView, coordinator: ()) {
          uiView.session.pause()
    }
    
    func pauseARView() {
        arView.session.pause()
    }
    
    func resumeARView() {
        bodySkeletonAnchor.children.removeAll()
        bodySkeleton = nil
        arView.session.run(ARBodyTrackingConfiguration())
    }
    
}

extension ARView: ARSessionDelegate {
    func setupForBodyTracking() {
        let configuration = ARBodyTrackingConfiguration()
        self.session.run(configuration)
        
        self.session.delegate = self
    }
    
    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }
            let bodyPosition = simd_make_float3(bodyAnchor.transform.columns.3)
            bodySkeletonAnchor.position = bodyPosition
            bodySkeletonAnchor.orientation = Transform(matrix: bodyAnchor.transform).rotation
            
            if let skeleton = bodySkeleton {
                skeleton.update(with: bodyAnchor)
            } else {
                bodySkeleton = BodySkeleton(for: bodyAnchor)
                bodySkeletonAnchor.addChild(bodySkeleton!)
            }
   
            if let character = characterEntity, character.parent == nil {
                // Attach the character to its anchor as soon as
                // 1. the body anchor was detected and
                // 2. the character was loaded.
                bodySkeletonAnchor.addChild(character)
            }
        }
    }
}
