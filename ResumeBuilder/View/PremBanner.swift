//
//  PremBanner.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 14.03.2025.
//

import SwiftUI

struct PremBanner: View {
    var body: some View {
        HStack{
            Image(.prem)
                .resizable()
                .frame(width: 152, height: 95)
            Spacer()
            VStack(spacing: 5){
                Text("Try Premium")
                    .font(.system(size: 20, weight: .semibold))
                Text("Get unlimited access")
                    .font(.system(size: 12, weight: .regular))
                Text("Upgrade Now")
                    .foregroundStyle(Color(hex: "#444444"))
                    .font(.system(size: 20, weight: .semibold))
                    .padding()
                    .frame(height: 49)
                    .background(Color(hex: "#F8FBFF"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
            }
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
            .foregroundStyle(.white)
        }
        .padding(.horizontal)
        .frame(height: 120)
        .background(Color(hex: "1A73E8"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

#Preview {
    PremBanner()
}
