//
//  ARView.swift
//  BodyTracking
//
//  Created by william on 2024/6/19.
//

import SwiftUI
import RealityKit

struct SkeletonView: View {
    var selection: DisplayOption
    @State private var isPaused = false
    private var arViewContainer: ARViewContainer
    
    init(selection: DisplayOption) {
        self.selection = selection
        self.arViewContainer = ARViewContainer(selection: selection)
    }
    
    var body: some View {
        ZStack {
            arViewContainer
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
//                    Picker("选择显示类型", selection: $selection) {
//                        ForEach(DisplayOption.allCases, id: \.self) { option in
//                            Text(option.rawValue)
//                                .frame(height: 40)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                    .frame(maxWidth: .infinity, maxHeight: 40)
//                    .padding()
//                    .layoutPriority(1)
                    
                    Button(action: {
                        isPaused ? arViewContainer.resumeARView() : arViewContainer.pauseARView()
                        isPaused.toggle()
                    }) {
                        HStack {
                            Image(systemName: !isPaused ? "pause" : "play")
                            Text(!isPaused ? "暂停" : "开始")
                                .font(.title3)
                                
                        }
                        .frame(width: 180, height: 40)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding()
//                    .layoutPriority(1)
//                    .foregroundColor(Color.primary)
                }
                .padding()
            }
        }
        
    }
}

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)  // << here !!
    }
}

struct SkeletonPreview: View {
    @State private var isPaused = false
    @State private var selection = DisplayOption.skeleton
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Picker("选择显示类型", selection: $selection) {
                    ForEach(DisplayOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                            .frame(height: 40)
                    }
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .padding()
                .layoutPriority(1)
                
                Button(action: {
                    isPaused.toggle()
                }) {
                    HStack {
                        Image(systemName: !isPaused ? "pause" : "play")
                        Text(!isPaused ? "暂停" : "开始")
                            .font(.footnote)
                            
                    }
                    .frame(maxWidth: 100, maxHeight: 40)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .padding()
                .layoutPriority(1)
                .foregroundColor(Color.primary)
            }
            .padding()
        }
    }
}

#Preview {
    SkeletonPreview()
}
