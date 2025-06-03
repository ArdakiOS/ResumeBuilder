//
//  ResultCVPreview.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 26.02.2025.
//

import SwiftUI

struct ResultCVPreview: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm : ResumeCreationViewModel
    @State var export = false
    @AppStorage("creationCount") var count = 0
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            if export {
                ResumeExport(vm: vm, export : $export)
                    .transition(.move(edge: .trailing))
            } else {
                VStack(spacing: 10){
                    HStack{
                        Button{
                            dismiss()
                            vm.pdfIsReady = false
                        } label: {
                            Image(.settingsBack)
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    
                        Spacer()
                        Text("Preview")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(.black)
                        Spacer()
                        
                        Button{
                            //presentSettings = true
                        } label: {
                            Image(.settings)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .opacity(0)
                        }
                        
                    }
                    .padding(.bottom, 10)
                    Spacer()
                    
                    if let url = vm.pdfHistoryURLS.last{
                        
                        PDFViewer(url: url)
                            .frame(maxWidth: 290, maxHeight: 427)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .shadow(color: Color(hex: "#2E2D2D").opacity(0.5), radius: 18, x: 0, y: 3)
                            .onAppear{
                                print(url)
                                print("ARRAY \(vm.pdfHistoryURLS)")
                            }
                    }
                            
                    
                    
                    Spacer()
                    
                    Button{
                        export.toggle()
                    } label: {
                        Text("Export")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 65)
                            .background(Color(hex: "#1A73E8"))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    
                }
                .padding(20)
                .transition(.move(edge: .leading))
            }
        }
        .onAppear{
            if count == 1 {
                requestAppReview()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: export)
    }
}
