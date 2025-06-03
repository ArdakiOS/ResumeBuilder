//
//  ResumeCreationContact.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//
import SwiftUI

struct ResumeCreationContact: View {
    @ObservedObject var vm : ResumeCreationViewModel
    @State var arrayOfLinks = [""]
    @State var offsets : [CGFloat] = [0]
    @State var tempSite = ""
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack{
                Color(hex: "#EEF0F1").ignoresSafeArea()
                    .onTapGesture {
                        dismissKeyboard()
                        
                    }
                VStack(spacing: 15){
                    ResumeCreationTextField(text: $vm.resume.email, prompt: Text("Email"))
                        .onChange(of: vm.resume.email) { oldValue in
                            vm.emailIsWrong = false
                        }
                    if vm.emailIsWrong{
                        Text("Please enter valid email")
                            .foregroundStyle(Color.red)
                            .font(.system(size: 16, weight: .regular))
                    }
                    
                    ResumeCreationTextField(text: $vm.resume.phone, prompt: Text("Phone"))
                    
                    ResumeCreationTextField(text: $vm.resume.address, prompt: Text("Address"))
                    
                    ResumeCreationTextField(text: $tempSite, prompt: Text("Weblink, Linkedin, Behance etc"))
                    
                    ForEach(arrayOfLinks.indices, id: \.self) { blockIndex in
                        ZStack(alignment: .trailing){
                            Button{
                                withAnimation {
                                    arrayOfLinks.remove(at: blockIndex)
                                    offsets.remove(at: blockIndex)
                                }
                            } label: {
                                Text("Delete")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .padding()
                                    .frame(width: 118)
                                    .background(Color.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .opacity(offsets[blockIndex] == 0 ? 0 : 1)
                            }
                            
                            ResumeCreationTextField(text: $arrayOfLinks[blockIndex], prompt: Text("Additional contact info"))
                                .offset(x: offsets[blockIndex])
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            if value.translation.width < 0 && value.translation.width > -130 {
                                                offsets[blockIndex] = value.translation.width
                                            } else if value.translation.width > 0 {
                                                withAnimation {
                                                    offsets[blockIndex] = 0
                                                }
                                            }
                                        }
                                        .onEnded { value in
                                            if value.translation.width < -50 {
                                                withAnimation {
                                                    offsets[blockIndex] = -128
                                                }
                                            } else {
                                                withAnimation {
                                                    offsets[blockIndex] = 0
                                                }
                                            }
                                        }
                                )
                            
                        }
                    }
                    
                    Button{
                        withAnimation {
                            offsets.append(0.0)
                            arrayOfLinks.append("")
                        }
                    } label: {
                        HStack{
                            Image(systemName: "plus")
                            Text("Add more")
                        }
                        .foregroundStyle(Color(hex: "#1A73E8"))
                        .font(.system(size: 16, weight: .regular))
                    }
                    
                    Rectangle().fill(Color(hex: "#EEF0F1")).frame(height: 300)
                        .onTapGesture {
                            dismissKeyboard()
                            
                        }
                    
                }
            }
        }
        .onDisappear{
            vm.resume.site = tempSite + ", " + arrayOfLinks.joined(separator: ", ")
        }
    }
}

#Preview {
    ResumeCreationView(vm : ResumeCreationViewModel())
}
