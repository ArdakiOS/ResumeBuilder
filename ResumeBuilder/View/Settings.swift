//
//  Settings.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 19.12.2024.
//

import SwiftUI
import StoreKit

struct Settings: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var subsMan : ApphudSubsManager
    let privacyURLStr = "https://telegra.ph/Privacy-Policy-03-14-101"
    let termsURLStr = "https://telegra.ph/Terms-of-Use-03-14-3"
    let shareLinkURLStr = "https://apps.apple.com/en/app/id6743325634"
    @State var showPaywall = false
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
                if !subsMan.hasSubscription {
                    PremBanner()
                        .onTapGesture {
                            subsMan.getPayWallProducts(id: ApphudPaywallIds.inapp.rawValue)
                            showPaywall = true
                        }
                }
                Button{
                    guard let url = URL(string: privacyURLStr) else {return}
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    SettingsButton(img: "Privacy", text: "Privacy Policy")
                }
                
                Button{
                    guard let url = URL(string: termsURLStr) else {return}
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    SettingsButton(img: "Terms", text: "Terms of use")
                }
                
                if let url = URL(string: shareLinkURLStr) {
                    ShareLink(item: url) {
                        SettingsButton(img: "Share", text: "Share")
                    }
                }
                
                
                Button{
                    requestAppReview()
                } label: {
                    SettingsButton(img: "Rate", text: "Rate us")
                }
                
                Spacer()
            }
            .padding(20)
        }
        .sheet(isPresented: $showPaywall) {
            PayWall(showPayWall: $showPaywall)
        }
    }
}

#Preview {
    Settings()
        .environmentObject(ApphudSubsManager())
}

struct SettingsButton : View {
    let img : String
    let text : String
    var body: some View {
        HStack{
            Image(img)
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(LocalizedStringKey(text))
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color(hex: "#444444"))
            
            Spacer()
        }
        .padding()
        .background(Color(hex: "#F8FBFF"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

func requestAppReview() {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
        SKStoreReviewController.requestReview(in: windowScene)
    }
}
