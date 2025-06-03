//
//  UploadingView.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 26.02.2025.
//

import SwiftUI

struct UploadingView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var rot = 0.0
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack(spacing: 20){
                VStack(spacing: 20){
                    Text("Your resume is created")
                        .font(.system(size: 22, weight: .semibold))
                    Image(.uploading)
                        .resizable()
                        .frame(width: 54, height: 54)
                        .rotationEffect(.degrees(rot))
                        .onReceive(timer) { _ in
                            rot += 360
                        }
                }
                .animation(.easeInOut(duration: 1), value: rot)
                .frame(maxHeight: .infinity, alignment: .bottom)
                Text("please don't close the application")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            .foregroundStyle(Color(hex: "#1A73E8"))
        }
        .onAppear{
            rot = 360
        }
    }
}

#Preview {
    UploadingView()
}
