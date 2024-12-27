//
//  LoadingImg.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 19.12.2024.
//

import SwiftUI

struct LoadingView: View {
    let timer = Timer.publish(every: 0.7, on: .main, in: .common).autoconnect()
    @Binding var progress : Double
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack(spacing: 30){
                Image(.loadingImg)
                    .resizable()
                    .frame(width: 148, height: 187)
                
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(hex: "#D9D9D9").opacity(0.8))
                        .frame(width: 174, height: 4)
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(hex: "#207EF9").opacity(0.8))
                        .frame(width: 174 * progress, height: 4)
                }
                
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.black.opacity(0.6))
                
            }
        }
        .onReceive(timer) { _ in
            let random = Double.random(in: 0...0.2)
            if progress + random > 1 {
                withAnimation {
                    progress = 1
                }
                
            } else {
                withAnimation {
                    progress += random
                }
                
            }
        }
    }
}

