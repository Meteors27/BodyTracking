//
//  ARView.swift
//  BodyTracking
//
//  Created by william on 2024/6/19.
//

import SwiftUI
import RealityKit

struct SkeletonView: View {
    @State private var shouldReset = false
    
    var body: some View {
        ZStack {
            ARViewContainer(resetFlag: $shouldReset)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Button(action: {
                    shouldReset.toggle() 
                }) {
                    Text("Reset")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        
    }
}
