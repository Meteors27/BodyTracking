//
//  ARViewContainer.swift
//  BodyTracking
//
//  Created by william on 2024/6/19.
//

import SwiftUI
import ARKit
import RealityKit

private var bodySkeleton: BodySkeleton?
private let bodySkeletonAnchor = AnchorEntity()

struct ARViewContainer: UIViewRepresentable {
    @Binding var pauseFlag: Bool
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
    func makeUIView(context: Context) -> ARView {
        self.arView.setupForBodyTracking()
        self.arView.scene.addAnchor(bodySkeletonAnchor)
        return self.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if pauseFlag {
//            arView.session.pause()
        } else {
//            arView.session.run(ARBodyTrackingConfiguration())
        }
    }
    static func dismantleUIView(_ uiView: ARView, coordinator: ()) {
          uiView.session.pause()
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
            if let bodyAnchor = anchor as? ARBodyAnchor {
                if let skeleton = bodySkeleton {
                    skeleton.update(with: bodyAnchor)
                } else {
                    bodySkeleton = BodySkeleton(for: bodyAnchor)
                    bodySkeletonAnchor.addChild(bodySkeleton!)
                }
            }
        }
    }
}
