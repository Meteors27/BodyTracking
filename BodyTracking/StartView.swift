//
//  SwiftUIView.swift
//  BodyTracking
//
//  Created by william on 2024/6/19.
//

import SwiftUI

struct StartView: View {
    @State private var selection = DisplayOption.skeleton
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                Image(systemName: "figure.highintensity.intervaltraining")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 100, height: 100)
                      .foregroundColor(.accentColor)
                      .padding()
                
                Text("人体姿态扫描仪")
                      .font(.title)
                      .padding()
                Text("使用iPhone的相机检测人体姿态，并通过增强现实可视化，让人体姿态栩栩如生。")
                      .padding()
                

                }
                VStack {
                    Spacer()
                    Picker("选择显示类型", selection: $selection) {
                        ForEach(DisplayOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                                .frame(height: 40)
                        }
                    }
                    NavigationLink(destination: SkeletonView(selection: selection), label: {Text("开始").frame(width: 180, height: 40)})
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .font(.title3)
                        .padding()
                    }
            }
        }
      }
}

#Preview {
    StartView()
}
