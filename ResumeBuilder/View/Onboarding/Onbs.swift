//
//  SwiftUIView.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 19.12.2024.
//

import SwiftUI
enum OnbTabs {
    case one, two, three
}

struct Onbs: View {
    @State var curPage = OnbTabs.one
    @Binding var didOnb : Bool
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            TabView(selection: $curPage) {
                Onb1(curPage: $curPage)
                    .tag(OnbTabs.one)
                Onb2(curPage: $curPage)
                    .tag(OnbTabs.two)
                Onb3(didOnb: $didOnb)
                    .tag(OnbTabs.three)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .animation(.easeInOut, value: curPage)
    }
}

struct Onb1 : View {
    @Binding var curPage : OnbTabs
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack(spacing: 10){
                Text("Start by filling out\nyour profile")
                    .font(.system(size: 26, weight: .semibold))
                    .multilineTextAlignment(.center)
                Spacer()
                ZStack{
                    Image(.onb1)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 370)
                        
                }
                Spacer()
                
            }
            .padding(20)
            
            VStack{
                Spacer()
                Button{
                    curPage = .two
                } label: {
                    Text("Next")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 65)
                        .background(Color(hex: "#1A73E8"))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                }
            }
            .padding(20)
        }
    }
}

struct Onb2 : View {
    @Binding var curPage : OnbTabs
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack(spacing: 10){
                Text("Choose a template\nthat suit your style")
                    .font(.system(size: 26, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .fixedSize()
                Spacer()
                
                ZStack{
                    Image(.onb2)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 530)
                        
                }
                Spacer()
                
            }
            .padding(20)
            
            VStack{
                Spacer()
                Button{
                    curPage = .three
                } label: {
                    Text("Next")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 65)
                        .background(Color(hex: "#1A73E8"))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                }
            }
            .padding(20)
        }
    }
}

struct Onb3 : View {
    @Binding var didOnb : Bool
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack(spacing: 10){
                Text("All templates\nwithout limitations")
                    .font(.system(size: 26, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .fixedSize()
                Spacer()
                
                Image(.onb3)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 530)
                
                Spacer()
                
            }
            .padding(20)
            
            VStack{
                Spacer()
                Button{
                    didOnb = true
                    UserDefaults.standard.set(true, forKey: "onb")
                } label: {
                    Text("Next")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 65)
                        .background(Color(hex: "#1A73E8"))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                }
            }
            .padding(20)
        }
    }
}
