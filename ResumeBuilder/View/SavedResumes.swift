//
//  SavedResumes.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 19.12.2024.
//

import SwiftUI
import PDFKit

struct SavedResumes: View {
    @Environment(\.dismiss) var dismiss
    @State var presentSettings = false
    @State var presentDetail = false
    @ObservedObject var vm : ResumeCreationViewModel
    @State var selectedPDF : URL?
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                        ForEach(vm.pdfHistoryURLS, id: \.self){cv in
                            Button{
                                selectedPDF = cv
                                presentDetail = true
                            } label: {
                                PDFViewer(url: cv)
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
                .environmentObject(subsMan)
        }
        .navigationDestination(isPresented: $presentDetail) {
            PreviewSavedResume(selectedPDF: selectedPDF, vm: vm)
                .navigationBarBackButtonHidden()
                .environmentObject(subsMan)
        }
    }
}

struct PDFViewer: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}

#Preview {
    SavedResumes(vm: ResumeCreationViewModel())
}
