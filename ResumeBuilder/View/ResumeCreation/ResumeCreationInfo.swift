//
//  ResumeCreationInfo.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//
import SwiftUI

struct ResumeCreationInfo : View {
    @ObservedObject var vm : ResumeCreationViewModel
    
    @State private var isPickerPresented = false
    @State private var selectedImage: UIImage?
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack{
                Color(hex: "#EEF0F1").ignoresSafeArea()
                    .onTapGesture {
                        dismissKeyboard()
                    }
                VStack(spacing: 15){
                    ZStack{
                        Button{
                            isPickerPresented.toggle()
                        } label:{
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 86, height: 86)
                                    .clipShape(Circle())
                                    .padding(.bottom, 40)
                            } else {
                                Image(.infoPage)
                                    .resizable()
                                    .frame(width: 86, height: 86)
                                    .padding(.bottom, 40)
                            }
                        }
                        
                    }
                    .onChange(of: selectedImage) { _ in
                        vm.resume.photo = vm.convertImageToBase64String(image: selectedImage!)!
                    }
                    
                    ResumeCreationTextField(text: $vm.infoFirstName, prompt: Text("First name"))
                        .onChange(of: vm.infoFirstName) { _ in
                            vm.resume.name = vm.infoFirstName + " " + vm.infoLastName
                        }
                    
                    ResumeCreationTextField(text: $vm.infoLastName, prompt: Text("Last name"))
                        .onChange(of: vm.infoLastName) { _ in
                            vm.resume.name = vm.infoFirstName + " " + vm.infoLastName
                        }
                    
                    ResumeCreationTextField(text: $vm.resume.title, prompt: Text("Job title"))
                    
                    Rectangle().fill(Color(hex: "#EEF0F1")).frame(height: 300)
                        .onTapGesture {
                            dismissKeyboard()
                        }
                }
                
            }
        }
        
        .sheet(isPresented: $isPickerPresented) {
            PhotoPicker(selectedImage: $selectedImage)
        }
    }
}

#Preview {
    ResumeCreationView(vm : ResumeCreationViewModel())
}
