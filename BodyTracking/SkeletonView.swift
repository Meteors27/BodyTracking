//
//  ARView.swift
//  BodyTracking
//
//  Created by william on 2024/6/19.
//

import SwiftUI
import RealityKit

struct SkeletonView: View {
    @State private var isPaused = false
    @State private var arViewContainer = ARViewContainer()
    
    var body: some View {
        ZStack {
            arViewContainer
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Button(action: {
                    isPaused ? arViewContainer.resumeARView() : arViewContainer.pauseARView()
                    isPaused.toggle()
                }) {
                    HStack {
                        Image(systemName: !isPaused ? "pause" : "play")
                        Text(!isPaused ? "暂停" : "开始")
                    }
                    .frame(width: 180, height: 40)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .font(.title3)
                .padding()
            }
        }
        
    }
}
