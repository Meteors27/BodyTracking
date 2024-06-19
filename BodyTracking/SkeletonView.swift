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
    
    var body: some View {
        ZStack {
            ARViewContainer(pauseFlag: $isPaused)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Button(action: {
                    isPaused.toggle()
                }) {
                    HStack {
                        Image(systemName: isPaused ? "pause" : "play")
                        Text(isPaused ? "暂停" : "开始")
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
