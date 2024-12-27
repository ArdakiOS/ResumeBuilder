//
//  Settings.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 19.12.2024.
//

import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack(spacing: 20){
                HStack{
                    Button{
                        dismiss()
                    } label: {
                        Image(.settingsBack)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()
                    
                    Text("Settings")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(Color(hex: "#444444"))
                    
                    Spacer()
                    
                    Image(.settingsBack)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .opacity(0)
                }
                
                SettingsButton(img: "Privacy", text: "Privacy Policy")
                SettingsButton(img: "Terms", text: "Terms of use")
                SettingsButton(img: "Share", text: "Share")
                SettingsButton(img: "Rate", text: "Rate us")
                
                Spacer()
            }
            .padding(20)
        }
    }
}

#Preview {
    Settings()
}

struct SettingsButton : View {
    let img : String
    let text : String
    var body: some View {
        HStack{
            Image(img)
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(text)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color(hex: "#444444"))
            
            Spacer()
        }
        .padding()
        .background(Color(hex: "#F8FBFF"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
