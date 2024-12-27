//
//  PreviewSavedResume.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 19.12.2024.
//

import SwiftUI

struct PreviewSavedResume: View {
    @State var presentSettings = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack(spacing: 10){
                HStack{
                    Button{
                        dismiss()
                    } label: {
                        Image(.settingsBack)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                
                    Spacer()
                    Text("My resume")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.black)
                    Spacer()
                    
                    Button{
                        presentSettings = true
                    } label: {
                        Image(.settings)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                }
                .padding(.bottom, 10)
                Spacer()
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(hex: "#EAE7E7"))
                    .padding(.horizontal)
                    .shadow(color: Color(hex: "#2E2D2D").opacity(0.5), radius: 18, x: 0, y: 3)
                
                Spacer()
                
                Button{
                    
                } label: {
                    Text("Edit")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 65)
                        .background(Color(hex: "#1A73E8"))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                Button{
                    
                } label: {
                    Text("Delete")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color(hex: "#E23A2E"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 65)
                        .background(RoundedRectangle(cornerRadius: 30).stroke(Color(hex: "#E23A2E")))
                }
                
                
            }
            .padding(20)
        }
        .navigationDestination(isPresented: $presentSettings) {
            Settings()
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    PreviewSavedResume()
}
