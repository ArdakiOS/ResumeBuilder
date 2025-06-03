//
//  ResumeCreationSkills.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//
import SwiftUI

struct ResumeCreationSkills : View {
    
    @ObservedObject var vm : ResumeCreationViewModel
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ZStack{
                Color(hex: "#EEF0F1").ignoresSafeArea()
                    .onTapGesture {
                        dismissKeyboard()
                    }
                VStack(spacing: 15){
                    ForEach(vm.resume.skills.indices, id: \.self) {blockIndex in
                        if blockIndex > 0 {
                            Button{
                                vm.resume.skills.remove(at: blockIndex)
                                
                            } label: {
                                Image(systemName: "xmark")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundStyle(.black)
                            }
                        }
                        ResumeCreationTextField(text: $vm.resume.skills[blockIndex].name, prompt: Text("Skill"))
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Please indicate your level")
                                .foregroundStyle(Color(hex: "#444444").opacity(0.44))
                                .font(.system(size: 16, weight: .regular))
                            HStack(spacing: 0){
                                ForEach(1..<11, id:\.self){lvl in
                                    Button{
                                        withAnimation {
                                            vm.resume.skills[blockIndex].level = lvl * 10
                                        }
                                    } label:{
                                        Circle()
                                            .fill(vm.resume.skills[blockIndex].level < lvl * 10 ? Color(hex: "#AAABAC") : Color(hex: "#5218FA"))
                                            .frame(width: 20, height: 20)
                                            .frame(maxWidth: .infinity)
                                    }
                                    if lvl < 10{
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Button{
                        withAnimation {
                            vm.resume.skills.append(Skill(name: "", level: 20))
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
        .animation(.easeInOut(duration: 0.6), value: vm.resume.skills)
    }
}

#Preview {
    ResumeCreationView(vm : ResumeCreationViewModel())
}
