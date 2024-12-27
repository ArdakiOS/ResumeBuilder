//
//  HomeView.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 19.12.2024.
//

import SwiftUI

struct HomeView: View {
    @State var presentSettings = false
    @State var presentResumeBuilder = false
    @State var presentMyResumes = false
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack(spacing: 10){
                HStack{
                    Text("Resume Builder")
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
                
                Text("Your professional resume")
                    .font(.system(size: 29, weight: .semibold))
                    .foregroundStyle(.black)
                
                Text("Create cv using a variety\nof templates")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(Color(hex: "#444444"))
                
                Spacer()
                
                Button{
                    presentResumeBuilder = true
                } label: {
                    Text("Get started")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 65)
                        .background(Color(hex: "#1A73E8"))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                Button{
                    presentMyResumes = true
                } label: {
                    Text("My resume")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color(hex: "#1A73E8"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 65)
                        .background(RoundedRectangle(cornerRadius: 30).stroke(Color(hex: "#1A73E8")))
                }
                
                
            }
            .padding(20)
        }
        .navigationDestination(isPresented: $presentSettings) {
            Settings()
                .navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $presentMyResumes) {
            SavedResumes()
                .navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $presentResumeBuilder) {
            ResumeCreationView()
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
