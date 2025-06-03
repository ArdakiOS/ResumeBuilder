//
//  ResumeCreationModel.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 23.01.2025.
//

import Foundation

struct ResumeCreationModel: Hashable, Codable {
    var template: String
    var name: String
    var title: String
    var phone: String
    var email: String
    var site: String
    var address: String
    var about_me: String
    var skills: [Skill]
    var experience: [ExperienceModel]
    var education: [EducationModel]
    var photo: String
    var projects : [ProjectModel]
    var language : [LanguageModel]
    var interests : [InterestsModel]
}

struct LanguageModel : Hashable, Codable {
    var name : String
}

struct InterestsModel : Hashable, Codable {
    var name : String
}

struct ProjectModel : Hashable, Codable {
    var name : String
    var description: String
}
struct Skill: Hashable, Codable {
    var name: String
    var level: Int
}

struct ExperienceModel: Hashable, Codable {
    var company: String
    var position: String
    var description: String
    var startWork: String
    var finishWork: String?
}

struct EducationModel: Hashable, Codable {
    var name: String
    var description: String
    var specialty: String
    var startSchool: String
    var finishSchool: String
}
