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
    @State var selectedPDF : URL?
    @ObservedObject var vm : ResumeCreationViewModel
    @EnvironmentObject var subsMan : ApphudSubsManager
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
                if let selectedPDF = selectedPDF {
                    PDFViewer(url: selectedPDF)
                        .frame(maxWidth: 290, maxHeight: 427)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .padding(.horizontal)
                        .shadow(color: Color(hex: "#2E2D2D").opacity(0.5), radius: 18, x: 0, y: 3)
                }
                Spacer()
                
                Button{
                    guard let url = selectedPDF else {return}
                    sharePDFURL(url: url)
                } label: {
                    Text("Share")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 65)
                        .background(Color(hex: "#1A73E8"))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                Button{
                    guard let url = selectedPDF else {return}
                    vm.deletePDF(at: url)
                    dismiss()
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
                .environmentObject(subsMan)
        }
    }
}

#Preview {
    PreviewSavedResume(vm: ResumeCreationViewModel())
}

func sharePDFURL(url : URL) {
    
        
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        // Get the topmost view controller
        if let topVC = UIApplication.shared.windows.first?.rootViewController {
            topVC.present(activityViewController, animated: true)
        }
}
