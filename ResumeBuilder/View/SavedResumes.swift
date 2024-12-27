//
//  SavedResumes.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 19.12.2024.
//

import SwiftUI

struct SavedResumes: View {
    @Environment(\.dismiss) var dismiss
    @State var presentSettings = false
    @State var presentDetail = false
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                        ForEach(0..<2, id: \.self){cv in
                            Button{
                                presentDetail = true
                            } label: {
                                RoundedRectangle(cornerRadius: 30).fill(Color(hex: "#DBD8D8"))
                                    .frame(height: 227)
                            }
                            
                        }
                    }
                }
                
                
            }
            .padding(20)
        }
        .navigationDestination(isPresented: $presentSettings) {
            Settings()
                .navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $presentDetail) {
            PreviewSavedResume()
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    SavedResumes()
}
