//
//  ResumeModel.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 18.12.2024.
//

import Foundation

struct ResumeModel : Equatable {
    var firstName : String
    var lastName : String
    var jobTitle : String
    var contact : [Contact]
    var work : [Work]
    var skills : String
    var education : [Education]
    var summary : String
}

struct Contact : Equatable {
    var email : String
    var phone : String
    var address : String
    var links : String
    var additionalInfo : [String]
}

struct Work : Equatable {
    var orgName : String
    var jobTitle : String
    var startDate : Date
    var endDate : Date?
    var stillWorkTher : Bool
}

struct Education : Equatable{
    var uniName : String
    var spec : String
    var startDate : Date
    var graduation : Date
    
}
