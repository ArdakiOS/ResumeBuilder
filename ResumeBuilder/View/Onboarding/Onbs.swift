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
    @EnvironmentObject var subsMan : ApphudSubsManager
    @Binding var showOnb : Bool
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack{
                switch curPage {
                case .one:
                    Onb1(curPage: $curPage)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case .two:
                    Onb2(curPage: $curPage)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case .three:
                    PayWall(showPayWall: $showOnb)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        .onAppear{
                            subsMan.getPayWallProducts(id: ApphudPaywallIds.onb.rawValue)
                        }
                }
            }
        }
        .animation(.easeInOut(duration: 0.6), value: curPage)
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
        .onAppear{
            requestAppReview()
        }
    }
}


