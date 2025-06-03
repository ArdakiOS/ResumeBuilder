//
//  ResumeCreationTemplate.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//

import SwiftUI

struct ResumeCreationTemplate: View {
    @ObservedObject var vm : ResumeCreationViewModel
    @EnvironmentObject var subsMan : ApphudSubsManager
    @State var showPayWall = false
    @AppStorage("creationCount") var count = 0
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                    ForEach(vm.templates, id: \.self){cv in
                        Button{
                            if subsMan.hasSubscription{
                                withAnimation {
                                    vm.resume.template = cv.num
                                }
                            } else {
                                if cv.isPrem {
                                    showPayWall = true
                                } else {
                                    if count == 2 {
                                        showPayWall = true
                                    } else {
                                        withAnimation {
                                            vm.resume.template = cv.num
                                        }
                                    }
                                }
                            }
                        } label: {
                            Image(cv.num)
                                .resizable()
                                .frame(width: 160, height: 227)
                                .overlay {
                                    if vm.resume.template == cv.num {
                                        RoundedRectangle(cornerRadius: 30).stroke(Color(hex: "#1A73E8"), lineWidth: 2)
                                            .shadow(color: Color(hex: "#1A73E8").opacity(0.5), radius: 8)
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .overlay(alignment: .topTrailing){
                                    if cv.isPrem {
                                        Image(.premReq)
                                            .resizable()
                                            .frame(width: 34, height: 34)
                                            .offset(y: -10)
                                    }
                                }
                                
                        }
                        
                    }
                }
                .padding(.top)
                
            }
        }
        .sheet(isPresented: $showPayWall) {
            PayWall(showPayWall: $showPayWall)
        }
    }
}

#Preview {
    ResumeCreationView(curTab: .template, vm : ResumeCreationViewModel())
        .environmentObject(ApphudSubsManager())
}
