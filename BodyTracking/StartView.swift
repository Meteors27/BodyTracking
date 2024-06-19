//
//  SwiftUIView.swift
//  BodyTracking
//
//  Created by william on 2024/6/19.
//

import SwiftUI

struct StartView: View {
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
                    NavigationLink(destination: SkeletonView(), label: {Text("开始").frame(width: 200, height: 50)})
                        .buttonStyle(.borderedProminent)
                        .cornerRadius(50)
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
