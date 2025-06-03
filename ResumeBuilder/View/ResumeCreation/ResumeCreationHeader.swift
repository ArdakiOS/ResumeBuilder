//
//  ResumeCreationHeader.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//
import SwiftUI

struct ResumeCreationHeader : View {
    @Binding var curTab : ResumeCreationTabs
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("Resume Builder")
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 22, weight: .semibold))
                }
            }
            .padding(.horizontal, 20)
            ScrollViewReader{ reader in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        ForEach(ResumeCreationTabs.allCases, id: \.self) {tab in
                            Button{
                                curTab = tab
                            } label: {
                                HStack{
                                    Image(tab.displayName())
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                    Text(LocalizedStringKey(tab.displayName()))
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundStyle(Color(hex: "#EBEBEB"))
                                }
                                .padding(10)
                                .frame(height: 35)
                                .background {
                                    if curTab == tab{
                                        tab.bgColor()
                                    }
                                    else {
                                        Color(hex: "#444444").opacity(0.4)
                                    }
                                }
                                .clipShape(Capsule())
                                
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .onChange(of: curTab) { _ in
                        withAnimation {
                            reader.scrollTo(curTab, anchor: .leading)
                        }
                    }
                }
                
            }
        }
        .foregroundStyle(.black)
    }
}
