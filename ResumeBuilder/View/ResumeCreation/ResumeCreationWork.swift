//
//  ResumeCreationWork.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//
import SwiftUI

struct ResumeCreationWork : View {
//    @Binding var workExp : [ExperienceModel]

    @ObservedObject var vm : ResumeCreationViewModel
    
    var body: some View {
        
            ScrollView(.vertical, showsIndicators: false) {
                ZStack{
                    Color(hex: "#EEF0F1").ignoresSafeArea()
                        .onTapGesture {
                            dismissKeyboard()
                        }
                VStack(spacing: 15){
                    if vm.noWorkExp == false {
                        ForEach(vm.resume.experience.indices, id: \.self) { blockIndex in
                            if blockIndex > 0 {
                                Button{
                                    vm.resume.experience.remove(at: blockIndex)
                                    
                                } label: {
                                    Image(systemName: "xmark")
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .font(.system(size: 22, weight: .semibold))
                                        .foregroundStyle(.black)
                                }
                            }
                            ResumeCreationTextField(text: $vm.resume.experience[blockIndex].company, prompt: Text("Organization name"))
                            ResumeCreationTextField(text: $vm.resume.experience[blockIndex].position, prompt: Text("Job title"))
                            ResumeCreationTextField(text: $vm.resume.experience[blockIndex].description, prompt: Text("Work tasks"))
                            ResumeCreationDatePicker(date: $vm.expStartDate[blockIndex], text: "Start Date")
                                .onChange(of: vm.expStartDate[blockIndex]) { _ in
                                    vm.resume.experience[blockIndex].startWork = formatDate(date: vm.expStartDate[blockIndex])
                                }
                            if !vm.expStillWorks[blockIndex]{
                                ResumeCreationDatePicker(date: $vm.expEndDate[blockIndex], text: "End Date")
                                    .onChange(of: vm.expEndDate[blockIndex]) { _ in
                                        vm.resume.experience[blockIndex].finishWork = formatDate(date: vm.expEndDate[blockIndex])
                                    }
                            }
                            HStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 5).fill(Color(hex: "#EEF0F1"))
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(hex: "#444444").opacity(0.70), lineWidth: 1.5)
                                        
                                        .padding(.leading, 1)
                                    if vm.expStillWorks[blockIndex] == true {
                                        Image(systemName: "checkmark")
                                            .frame(width: 20, height: 20)
                                    }
                                }
                                .frame(width: 26, height: 26)
                                
                                Text("I presently work here")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(Color(hex: "#444444").opacity(0.70))
                                Spacer()
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    vm.expStillWorks[blockIndex].toggle()
                                }
                            }
                            .onChange(of: vm.expStillWorks[blockIndex]) { _ in
                                if vm.expStillWorks[blockIndex]{
                                    vm.resume.experience[blockIndex].finishWork = nil
                                } else {
                                    vm.resume.experience[blockIndex].finishWork = formatDate(date: vm.expEndDate[blockIndex])
                                }
                            }
                            
                            
                        }
                    }
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 5).fill(Color(hex: "#EEF0F1"))
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(hex: "#444444").opacity(0.70), lineWidth: 1.5)
                                
                                .padding(.leading, 1)
                            if vm.noWorkExp == true {
                                Image(systemName: "checkmark")
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .frame(width: 26, height: 26)
                        
                        Text("No work experience")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color(hex: "#444444").opacity(0.70))
                        Spacer()
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            if vm.noWorkExp {
                                vm.resume.experience = [ExperienceModel(company: "", position: "", description: "", startWork: formatDate(date: Date()), finishWork: nil)]
                            }
                            else {
                                vm.resume.experience = []
                            }
                            vm.noWorkExp.toggle()
                            
                        }
                    }
                    if vm.noWorkExp == false {
                        Button{
                            withAnimation {
                                vm.resume.experience.append(ExperienceModel(company: "", position: "", description: "", startWork: ""))
                                vm.expStartDate.append(Date())
                                vm.expEndDate.append(Date())
                                vm.expStillWorks.append(false)
                            }
                        } label: {
                            HStack{
                                Image(systemName: "plus")
                                Text("Add more")
                            }
                            .foregroundStyle(Color(hex: "#1A73E8"))
                            .font(.system(size: 16, weight: .regular))
                        }
                    }
                    Rectangle().fill(Color(hex: "#EEF0F1")).frame(height: 300)
                        .onTapGesture {
                            dismissKeyboard()
                        }
                }
                
            }
        }
        .animation(.easeInOut(duration: 0.6), value: vm.resume.experience)
    }
}

#Preview {
    ResumeCreationView(vm : ResumeCreationViewModel())
}
