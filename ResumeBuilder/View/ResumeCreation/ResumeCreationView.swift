//
//  ResumeCreationView.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 18.12.2024.
//

import SwiftUI

enum ResumeCreationTabs : CaseIterable{
    case info, contact, work, skills, projects, language, education, summary
    case template
    
    func displayName () -> String{
        switch self {
        case .info:
            "Info"
        case .contact:
            "Contact"
        case .work:
            "Work"
        case .skills:
            "Skills"
        case .projects:
            "Projects"
        case .language:
            "Language"
        case .education:
            "Education"
        case .summary:
            "Summary"
            
        case .template:
            "Template"
        }
    }
    
    func bgColor() -> Color {
        switch self {
        case .info:
            Color(hex: "#E23A2E")
        case .contact:
            Color(hex: "#ECB71D")
        case .work:
            Color(hex: "#1A73E8")
        case .skills:
            Color(hex: "#5218FA")
        case .projects:
            Color(hex: "#0A34CE")
        case .language:
            Color(hex: "#CE0A62")
        case .education:
            Color(hex: "#279847")
        case .summary:
            Color(hex: "#3C4C60")
        case .template:
            Color(hex: "#023382")
        }
    }
}

struct ResumeCreationView: View {
    @State var curTab = ResumeCreationTabs.info
    @ObservedObject var vm : ResumeCreationViewModel
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack{
                ResumeCreationHeader(curTab: $curTab)
                    .padding(.top, 10)
                ZStack{
                    switch curTab {
                    case .info:
                        ResumeCreationInfo(vm: vm)
                    case .contact:
                        ResumeCreationContact(vm: vm)
                    case .work:
                        ResumeCreationWork(vm: vm)
                    case .skills:
                        ResumeCreationSkills(vm: vm)
                    case .projects:
                        ResumeCreationProjects(vm: vm)
                    case .language :
                        ResumeCreationLanguage(vm: vm)
                    case .education:
                        ResumeCreationEducation(vm: vm)
                    case .summary:
                        ResumeCreationSummary(vm: vm)
                    case .template:
                        ResumeCreationTemplate(vm: vm)
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 20)
            }
            .animation(.easeInOut, value: curTab)
            
            ResumeCreationSaveButton(vm: vm)
                .padding(.bottom, 10)
            
            if vm.pdfIsReady {
                ResultCVPreview(vm: vm)
            }
            
            if vm.startedCreation {
                UploadingView()
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
        .alert("Missing information", isPresented: $vm.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(LocalizedStringKey(vm.alertText))
        }
    }
}

#Preview {
    ResumeCreationView(vm : ResumeCreationViewModel())
}

struct ResumeCreationSaveButton : View {
    @ObservedObject var vm : ResumeCreationViewModel
    @AppStorage("creationCount") var count = 0
    var body: some View {
        VStack{
            Spacer()
            Button {
                if vm.canGenerate(){
                    vm.createResume()
                    count += 1
                } else {
                    print(vm.resume)
                    if vm.containsAtAndCharAfter(vm.resume.email){
                        vm.showAlert = true
                        vm.alertText = "Make sure you provided all required information"
                    } else {
                        vm.emailIsWrong = true
                        vm.showAlert = true
                        vm.alertText = "Make sure you provided valid email"
                    }
                    
                }
            } label: {
                Text("Save")
                    .foregroundStyle(.white.opacity(0.60))
                    .font(.system(size: 20, weight: .semibold))
                    .frame(width: 269, height: 65)
                    .background(vm.canGenerate() ? Color(hex: "#1A73E8") : Color(hex: "#6693CF"))
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .disabled(!vm.canGenerate())
                
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

func dismissKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}












