//
//  PayWall.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 14.03.2025.
//

import SwiftUI

struct PayWall : View {
    @Binding var showPayWall : Bool
    @EnvironmentObject var subsMan : ApphudSubsManager
    @State var selectedID = ""
    let privacyURLStr = "https://telegra.ph/Privacy-Policy-03-14-101"
    let termsURLStr = "https://telegra.ph/Terms-of-Use-03-14-3"
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack(spacing: 10){
                VStack(spacing: 0){
                    Button{
                        withAnimation {
                            showPayWall = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color(hex: "#444444").opacity(0.5))
                            .bold()
                            .frame(width: 17.5, height: 17.5)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }
                    Text("All templates\nwithout limitations")
                        .font(.system(size: 26, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .fixedSize()
                }
                Spacer()
                
                Image(.onb3)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 313 ,maxHeight: 520)
                    .clipped()
                
                Spacer()
                
            }
            .padding(20)
            
            VStack(spacing: 15){
                Spacer()
                
                    ForEach(subsMan.products, id: \.self){prod in
                        ZStack{
                            if prod.skProduct.id.contains("week"){
                                ProductRow(id: prod.skProduct.id, name: "Weekly", price: prod.skProduct.displayPrice, selectedProdId: $selectedID)
                            } else {
                                ProductRow(id: prod.skProduct.id, name: "Yearly", price: prod.skProduct.displayPrice, selectedProdId: $selectedID)
                            }
                        }
                        .onAppear{
                            subsMan.selectedAppHudProduct = prod.appHudProduct
                            selectedID = prod.skProduct.id
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)){
                                subsMan.selectedAppHudProduct = prod.appHudProduct
                                selectedID = prod.skProduct.id
                            }
                        }
                        .onChange(of: subsMan.hasSubscription) { oldValue in
                            showPayWall = false
                        }
                    }
                
                
                
                Button{
                    Task{
                        await subsMan.makePruchase()
                    }
                    
                } label: {
                    Text("Next")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(width: 335, height: 65)
                        .background(Color(hex: "#1A73E8"))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                }
                
                HStack{
                    Spacer()
                    Button{
                        Task{
                            await subsMan.restorePurchase()
                        }
                    } label: {
                        Text("Restore")
                            
                    }
                    
                    Spacer()
                    Button{
                        guard let url = URL(string: termsURLStr) else {return}
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("Terms")
                            
                    }
                    
                    Spacer()
                    Button{
                        guard let url = URL(string: privacyURLStr) else {return}
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("Privacy")
                            
                    }
                    Spacer()
                }
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color(hex: "#444444"))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 5)
        }
    }
}

#Preview {
    PayWall(showPayWall: .constant(true))
        .environmentObject(ApphudSubsManager())
}


struct ProductRow : View {
    let id : String
    let name : String
    let price : String
    @Binding var selectedProdId : String
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(LocalizedStringKey(name))
                .font(.system(size: 18, weight: .semibold))
                
            
            Text(price)
                .font(.system(size: 16, weight: .regular))
        }
        .foregroundStyle(Color(hex: "#2E2D2D"))
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
        .frame(maxWidth: 313, alignment: .leading)
        .background{
            ZStack{
                Color(hex: "#E2E7ED")
                if id == selectedProdId {
                    Color(hex: "#F2F8FF")
                }
            }
        }
        .overlay{
            if id == selectedProdId {
                RoundedRectangle(cornerRadius: 20).stroke(Color(hex: "#1255AE"), lineWidth: 1)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.25),radius: 10, y: 3)
    }
}
