//
//  ResumeCreationView.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 18.12.2024.
//

import SwiftUI

enum ResumeCreationTabs : CaseIterable{
    case info, contact, work, skills, education, summary, template
    
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
    
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack{
                ResumeCreationHeader(curTab: $curTab)
                    .padding(.top, 10)
                TabView(selection: $curTab) {
                    ResumeCreationInfo()
                        .tag(ResumeCreationTabs.info)
                    ResumeCreationContact()
                        .tag(ResumeCreationTabs.contact)
                    ResumeCreationWork()
                        .tag(ResumeCreationTabs.work)
                    ResumeCreationSkills()
                        .tag(ResumeCreationTabs.skills)
                    ResumeCreationEducation()
                        .tag(ResumeCreationTabs.education)
                    ResumeCreationSummary()
                        .tag(ResumeCreationTabs.summary)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .padding(.top, 30)
                .padding(.horizontal, 20)
            }
            .animation(.easeInOut, value: curTab)
            
            ResumeCreationSaveButton()
                .padding(.bottom, 10)
        }
    }
}

#Preview {
    ResumeCreationView()
}

struct ResumeCreationSaveButton : View {
    var body: some View {
        VStack{
            Spacer()
            Button {
                //
            } label: {
                Text("Save")
                    .foregroundStyle(.white.opacity(0.60))
                    .font(.system(size: 20, weight: .semibold))
                    .frame(width: 269, height: 65)
                    .background(Color(hex: "#6693CF"))
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                
            }
        }
    }
}

struct ResumeCreationHeader : View {
    @Binding var curTab : ResumeCreationTabs
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("Resume Builder")
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 22, weight: .semibold))
                }
            }
            .padding(.horizontal, 20)
            ScrollViewReader{ reader in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        ForEach(ResumeCreationTabs.allCases, id: \.self) {tab in
                            Button{
                                curTab = tab
                            } label: {
                                HStack{
                                    Image(tab.displayName())
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                    Text(tab.displayName())
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundStyle(Color(hex: "#EBEBEB"))
                                }
                                .padding(10)
                                .frame(height: 35)
                                .background {
                                    if curTab == tab{
                                        tab.bgColor()
                                    }
                                    else {
                                        Color(hex: "#444444").opacity(0.4)
                                    }
                                }
                                .clipShape(Capsule())
                                
                            }
                        }
                    }
                    .onChange(of: curTab) { oldValue, newValue in
                        withAnimation {
                            reader.scrollTo(curTab, anchor: .leading)
                        }
                    }
                }
                .padding(.leading, 20)
            }
        }
        .foregroundStyle(.black)
    }
}

struct ResumeCreationTextField : View {
    @Binding var text : String
    let prompt : Text
    var body: some View {
        HStack{
            TextField("", text: $text, prompt: prompt.font(.system(size: 20, weight: .semibold)).foregroundStyle(Color(hex: "#444444").opacity(0.30)))
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 20)
        .background(Color(hex:"#F8FBFF"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct ResumeCreationInfo : View {
    @State var text : String = ""
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack(spacing: 15){
                Image(.infoPage)
                    .resizable()
                    .frame(width: 86, height: 86)
                    .padding(.bottom, 40)
                
                ResumeCreationTextField(text: $text, prompt: Text("First name"))
                
                ResumeCreationTextField(text: $text, prompt: Text("Last name"))
                
                ResumeCreationTextField(text: $text, prompt: Text("Job title"))
                
                Spacer()
            }
        }
    }
}

struct ResumeCreationContact: View {
    @State var contact : Contact = Contact(email: "", phone: "", address: "", links: "", additionalInfo: [])
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    ResumeCreationTextField(text: $contact.email, prompt: Text("Email"))
                    
                    ResumeCreationTextField(text: $contact.phone, prompt: Text("Phone"))
                    
                    ResumeCreationTextField(text: $contact.address, prompt: Text("Address"))
                    
                    ResumeCreationTextField(text: $contact.links, prompt: Text("Weblink, Linkedin, Behance etc"))
                    ForEach(contact.additionalInfo.indices, id: \.self) { blockIndex in
                        ResumeCreationTextField(text: $contact.additionalInfo[blockIndex], prompt: Text("Additional contact info"))
                    }
                    
                    Button{
                        withAnimation {
                            contact.additionalInfo.append("")
                        }
                    } label: {
                        HStack{
                            Image(systemName: "plus")
                            Text("Add more")
                        }
                        .foregroundStyle(Color(hex: "#1A73E8"))
                        .font(.system(size: 16, weight: .regular))
                    }
                    
                    Rectangle().fill(Color(hex: "#EEF0F1"))
                        .frame(height: 75)
                    
                }
            }
            
        }
    }
}

struct ResumeCreationWork : View {
    @State var work : [Work] = [Work(orgName: "", jobTitle: "", startDate: Date(), endDate: Date(), stillWorkTher: false)]
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    ForEach(work.indices, id: \.self) { blockIndex in
                        ResumeCreationTextField(text: $work[blockIndex].orgName, prompt: Text("Organization name"))
                        ResumeCreationTextField(text: $work[blockIndex].jobTitle, prompt: Text("Job title"))
                        ResumeCreationTextField(text: $work[blockIndex].orgName, prompt: Text("Start Date"))
                        ResumeCreationTextField(text: $work[blockIndex].orgName, prompt: Text("End Date"))
                        
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(hex: "#444444").opacity(0.70), lineWidth: 1.5)
                                    .frame(width: 26, height: 26)
                                    .padding(.leading, 1)
                                if work[blockIndex].stillWorkTher {
                                    Image(systemName: "checkmark")
                                }
                            }
                            .onTapGesture {
                                withAnimation {
                                    work[blockIndex].stillWorkTher.toggle()
                                }
                            }
                            
                            Text("I presently attend here")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Color(hex: "#444444").opacity(0.70))
                            Spacer()
                        }
                        
                    }
                    Button{
                        withAnimation {
                            work.append(Work(orgName: "", jobTitle: "", startDate: Date(), endDate: Date(), stillWorkTher: false))
                        }
                    } label: {
                        HStack{
                            Image(systemName: "plus")
                            Text("Add more")
                        }
                        .foregroundStyle(Color(hex: "#1A73E8"))
                        .font(.system(size: 16, weight: .regular))
                    }
                    
                    Rectangle().fill(Color(hex: "#EEF0F1"))
                        .frame(height: 75)
                }
            }
        }
    }
}

struct ResumeCreationSkills : View {
    @State var skills = ""
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack{
                TextField("", text: $skills, prompt: Text("Write your skills").font(.system(size: 20, weight: .semibold)).foregroundStyle(Color(hex: "#444444").opacity(0.30)), axis: .vertical)
                    .lineLimit(10, reservesSpace: true)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                    .background(Color(hex:"#F8FBFF"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
            }
        }
    }
}

struct ResumeCreationEducation : View {
    @State var education : [Education] = [Education(uniName: "", spec: "", startDate: Date(), graduation: Date())]
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    ForEach(education.indices, id: \.self) { blockIndex in
                        ResumeCreationTextField(text: $education[blockIndex].uniName, prompt: Text("University name"))
                        ResumeCreationTextField(text: $education[blockIndex].spec, prompt: Text("Specialization"))
                        ResumeCreationTextField(text: $education[blockIndex].spec, prompt: Text("Start Date"))
                        ResumeCreationTextField(text: $education[blockIndex].spec, prompt: Text("Graduation Date"))
                        
                    }
                    Button{
                        withAnimation {
                            education.append(Education(uniName: "", spec: "", startDate: Date(), graduation: Date()))
                        }
                    } label: {
                        HStack{
                            Image(systemName: "plus")
                            Text("Add more")
                        }
                        .foregroundStyle(Color(hex: "#1A73E8"))
                        .font(.system(size: 16, weight: .regular))
                    }
                    
                    Rectangle().fill(Color(hex: "#EEF0F1"))
                        .frame(height: 75)
                }
            }
        }
    }
}

struct ResumeCreationSummary : View {
    @State var summary = ""
    var body: some View {
        ZStack{
            Color(hex: "#EEF0F1").ignoresSafeArea()
            VStack{
                TextField("", text: $summary, prompt: Text("Short summary about yourself").font(.system(size: 20, weight: .semibold)).foregroundStyle(Color(hex: "#444444").opacity(0.30)), axis: .vertical)
                    .lineLimit(10, reservesSpace: true)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                    .background(Color(hex:"#F8FBFF"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
            }
        }
    }
}
