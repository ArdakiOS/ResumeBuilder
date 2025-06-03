//
//  ResumeCreationSummary.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//
import SwiftUI

struct ResumeCreationSummary : View {
    @ObservedObject var vm : ResumeCreationViewModel
    @State var offsets : [CGFloat] = [0]
    var body: some View {
       
            ScrollView(.vertical, showsIndicators: false) {
                ZStack{
                    Color(hex: "#EEF0F1").ignoresSafeArea()
                        .onTapGesture {
                            dismissKeyboard()
                        }
                VStack(spacing: 15){
                    TextField("", text: $vm.resume.about_me, prompt: Text("Short summary about yourself").font(.system(size: 20, weight: .semibold)).foregroundColor(Color(hex: "#444444").opacity(0.30)), axis: .vertical)
                        .lineLimit(10, reservesSpace: true)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 20)
                        .background(Color(hex:"#F8FBFF"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    ForEach(vm.resume.interests.indices, id: \.self){blockIndex in
                        ZStack(alignment: .trailing){
                            Button{
                                withAnimation {
                                    vm.resume.interests.remove(at: blockIndex)
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
                            
                            
                            ResumeCreationTextField(text: $vm.resume.interests[blockIndex].name, prompt: Text(String(format: NSLocalizedString("Interest %@", comment: ""), "\(blockIndex + 1)")))
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
                            vm.resume.interests.append(InterestsModel(name: ""))
                            offsets.append(0)
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
    }
}

#Preview {
    ResumeCreationView(vm : ResumeCreationViewModel())
}
