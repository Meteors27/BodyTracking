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

enum DisplayOption: String, CaseIterable {
    case skeleton = "骨架"
    case character = "机器人"
}

private var displayOption: DisplayOption?

struct ARViewContainer: UIViewRepresentable {
    var selection: DisplayOption
    private let arView: ARView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
    func makeUIView(context: Context) -> ARView {
        print("make UI View")
        
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
        
        displayOption = selection
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
    
    static func dismantleUIView(_ uiView: ARView, coordinator: ()) {
        print("dismantle UI View")
        
//        bodySkeletonAnchor.children.removeAll()
//        bodySkeleton?.isEnabled = false
//        bodySkeleton?.joints.removeAll()
//        bodySkeleton?.bones.removeAll()
        bodySkeleton?.removeFromParent()
        bodySkeleton = nil
        characterEntity?.removeFromParent()
        characterEntity = nil
        uiView.session.delegate = nil
        uiView.session.pause()
        uiView.scene.anchors.removeAll()
    }
    
    func pauseARView() {
        arView.session.pause()
    }
    
    func resumeARView() {
//        bodySkeletonAnchor.children.removeAll()
//        bodySkeleton = nil
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
            
            if displayOption == .skeleton {
                if let skeleton = bodySkeleton {
                    skeleton.update(with: bodyAnchor)
                } else {
                    bodySkeleton = BodySkeleton(for: bodyAnchor)
                    bodySkeletonAnchor.addChild(bodySkeleton!)
                }
                characterEntity?.removeFromParent()
                characterEntity = nil
            } else if displayOption == .character {
                if let character = characterEntity, character.parent == nil {
                    // Attach the character to its anchor as soon as
                    // 1. the body anchor was detected and
                    // 2. the character was loaded.
                    bodySkeletonAnchor.addChild(character)
                }
                bodySkeleton?.removeFromParent()
                bodySkeleton = nil
            }
        }
    }
}
