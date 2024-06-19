//
//  ARViewContainer.swift
//  BodyTracking
//
//  Created by william on 2024/6/19.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}
