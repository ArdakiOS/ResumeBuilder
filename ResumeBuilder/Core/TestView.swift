//import SwiftUI
//
//struct TestView : View {
//    @State var name = ""
//    @State var selectedOpt = exportOptions.jpg
//    @StateObject var vm = ResumeCreationViewModel()
//    @State private var showShareSheet = false
//    @State private var shareItems: [Any] = []
//    @State var export: Bool = true
//    var body: some View {
//        ZStack{
//            Color(hex: "#EEF0F1").ignoresSafeArea()
//            VStack(spacing: 20){
//                HStack{
//                    Button{
//                        export = false
//                    } label: {
//                        Image(.settingsBack)
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                    }
//                
//                    Spacer()
//                    Text("Export")
//                        .font(.system(size: 22, weight: .semibold))
//                        .foregroundStyle(.black)
//                    Spacer()
//                    
//                    Button{
////                        presentSettings = true
//                    } label: {
//                        Image(.settings)
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .opacity(0)
//                    }
//                    
//                }
//                .padding(.bottom, 10)
//                
//                ResumeCreationTextField(text: $name, prompt: Text("File name"))
//                
//                Text("Export format")
//                    .font(.system(size: 18, weight: .semibold))
//                    .foregroundStyle(.black)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                HStack{
//                    ForEach(exportOptions.allCases , id: \.self) {opt in
//                        Button{
//                            withAnimation {
//                                selectedOpt = opt
//                            }
//                        } label: {
//                            Text(opt.name())
//                                .padding(.vertical, 10)
//                                .padding(.horizontal, 20)
//                                .background{
//                                    if opt == selectedOpt {
//                                        Color(hex: "#1A73E8")
//                                    } else {
//                                        Color.white
//                                    }
//                                }
//                                .foregroundStyle(opt == selectedOpt ? Color.white : Color(hex: "#1A73E8"))
//                                .font(.system(size: 20, weight: .semibold))
//                                .clipShape(RoundedRectangle(cornerRadius: 30))
//                        }
//                        
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                
//                if !vm.convertPDFToImages().isEmpty {
//                    Image(uiImage: vm.convertPDFToImages()[0])
//                        .resizable()
//                        .scaledToFit()
//                }
//                Spacer()
//                
//                Button{
//                    guard !name.isEmpty else {return}
//                    if selectedOpt == .jpg || selectedOpt == .png {
//                        let images = vm.convertPDFToImages()
//                        shareImage(image: images, name: name)
//                    } else {
//                        guard let data = vm.pdfData else {return}
//                        sharePDF(pdfData: data, name: name)
//                    }
//                } label: {
//                    Text("Export")
//                        .font(.system(size: 20, weight: .semibold))
//                        .foregroundStyle(.white)
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 65)
//                        .background(Color(hex: "#1A73E8"))
//                        .clipShape(RoundedRectangle(cornerRadius: 30))
//                }
//            }
//            .padding(20)
//            .sheet(isPresented: $showShareSheet) {
//                ShareSheet(items: shareItems)
//            }
//        }
//        .animation(.easeInOut(duration: 0.3), value: export)
//        .onAppear{
//            vm.result = ResumeCreationResponse(message: "", url: "https://resbuuldr.fun/storage/resumes/resume_1741859810.pdf")
//            Task{
//                await vm.loadPDFFromUrl()
//            }
//        }
//    }
//}
//
//func shareImage(image: [UIImage], name : String) {
//    var tempURLS : [URL] = []
//    for i in image{
//        guard let imageData = i.jpegData(compressionQuality: 1.0) else {
//            print("Error converting image to data")
//            return
//        }
//        
//        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(name).jpg")
//        do {
//            try imageData.write(to: tempURL)
//            tempURLS.append(tempURL)
//        } catch {
//            print("Error saving image to tempURL: \(error.localizedDescription)")
//            return
//        }
//        
//        
//    }
//    
//    let activityViewController = UIActivityViewController(activityItems: tempURLS, applicationActivities: nil)
//    
//    // Get the topmost view controller
//    if let topVC = UIApplication.shared.windows.first?.rootViewController {
//        topVC.present(activityViewController, animated: true)
//    }
//}
//
//func sharePDF(pdfData: Data, name : String) {
//    let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(name).pdf")
//
//    do {
//        try pdfData.write(to: tempURL)
//        
//        let activityViewController = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
//        
//        // Get the topmost view controller
//        if let topVC = UIApplication.shared.windows.first?.rootViewController {
//            topVC.present(activityViewController, animated: true)
//        }
//    } catch {
//        print("Error saving PDF to tempURL: \(error.localizedDescription)")
//    }
//}
//
