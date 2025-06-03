//
//  ContentView.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 18.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State var progress = 0.0
    @AppStorage("onb") var showOnb = true
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            if progress < 1 {
                LoadingView(progress: $progress)
            } else {
                if showOnb {
                    Onbs(showOnb: $showOnb)
                } else {
                    HomeView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
