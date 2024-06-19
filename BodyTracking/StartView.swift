//
//  SwiftUIView.swift
//  BodyTracking
//
//  Created by william on 2024/6/19.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        NavigationStack {
          VStack {
            Image(systemName: "camera.metering.matrix")
              .imageScale(.large)
              .foregroundColor(.accentColor)
            Text("Roomscanner").font(.title)
            Spacer().frame(height: 40)
            Text("Scan the room by pointing the camera at all surfaces. Model export supports usdz format.")
            Spacer().frame(height: 40)
            NavigationLink(destination: ScanningView(), label: {Text("Start Scan")}).buttonStyle(.borderedProminent).cornerRadius(40).font(.title2)
          }
        }
      }
    }
}

#Preview {
    SwiftUIView()
}
