//
//  ResumeCreationEducation.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//
import SwiftUI

struct ResumeCreationEducation : View {
    @ObservedObject var vm : ResumeCreationViewModel
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ZStack{
                Color(hex: "#EEF0F1").ignoresSafeArea()
                    .onTapGesture {
                        dismissKeyboard()
                    }
                VStack(spacing: 15){
                    ForEach(vm.resume.education.indices, id: \.self) { blockIndex in
                        if blockIndex > 0 {
                            Button{
                                vm.resume.education.remove(at: blockIndex)
                                
                            } label: {
                                Image(systemName: "xmark")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundStyle(.black)
                            }
                        }
                        ResumeCreationTextField(text: $vm.resume.education[blockIndex].name, prompt: Text("University name"))
                        ResumeCreationTextField(text: $vm.resume.education[blockIndex].specialty, prompt: Text("Specialization"))
                        ResumeCreationDatePicker(date: $vm.eduStartDate[blockIndex], text: "Start Date")
                            .onChange(of: vm.eduStartDate[blockIndex]) { _ in
                                vm.resume.education[blockIndex].startSchool = formatDate(date: vm.eduStartDate[blockIndex])
                            }
                        
                        ResumeCreationDatePicker(date: $vm.eduEndDate[blockIndex], text: "Graduation Date")
                            .onChange(of: vm.eduEndDate[blockIndex]) { _ in
                                vm.resume.education[blockIndex].finishSchool = formatDate(date: vm.eduEndDate[blockIndex])
                            }
                        
                        
                    }
                    Button{
                        withAnimation {
                            vm.resume.education.append(EducationModel(name: "", description: "", specialty: "", startSchool: "", finishSchool: ""))
                            vm.eduStartDate.append(Date())
                            vm.eduEndDate.append(Date())
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
        .animation(.easeInOut(duration: 0.6), value: vm.resume.education)
    }
}
#Preview {
    ResumeCreationView(vm : ResumeCreationViewModel())
}
