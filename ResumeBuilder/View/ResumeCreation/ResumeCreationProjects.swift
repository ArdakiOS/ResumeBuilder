//
//  ResumeCreationProjects.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//

import SwiftUI

struct ResumeCreationProjects: View {
    @ObservedObject var vm : ResumeCreationViewModel
    var body: some View {
        
            ScrollView(.vertical, showsIndicators: false) {
                ZStack{
                    Color(hex: "#EEF0F1").ignoresSafeArea()
                        .onTapGesture {
                            dismissKeyboard()
                        }
                VStack(spacing: 25){
                    ForEach(vm.resume.projects.indices, id: \.self){blockIndex in
                        VStack(spacing: 15) {
                            if blockIndex > 0 {
                                Button{
                                    vm.resume.projects.remove(at: blockIndex)
                                    
                                } label: {
                                    Image(systemName: "xmark")
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .font(.system(size: 22, weight: .semibold))
                                        .foregroundStyle(.black)
                                }
                            }
                            ResumeCreationTextField(text: $vm.resume.projects[blockIndex].name, prompt: Text("Name of Project"))
                            TextField("", text: $vm.resume.projects[blockIndex].description, prompt: Text("Short summary about the project").font(.system(size: 20, weight: .semibold)).foregroundColor(Color(hex: "#444444").opacity(0.30)), axis: .vertical)
                                .lineLimit(10, reservesSpace: true)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 20)
                                .background(Color(hex:"#F8FBFF"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    Button{
                        withAnimation {
                            vm.resume.projects.append(ProjectModel(name: "", description: ""))
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
            .animation(.easeInOut(duration: 0.6), value: vm.resume.projects)
        }
        
    }
}

#Preview {
    ResumeCreationView(vm : ResumeCreationViewModel())
}
