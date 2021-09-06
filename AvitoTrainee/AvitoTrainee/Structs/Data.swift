//
//  Data.swift
//  AvitoTrainee
//
//  Created by Никита Литвинов on 06.09.2021.
//

import Foundation


struct OneCompany: Codable{
    let company: Company
}


struct Company: Codable {
    let name: String
    let employees: [Employee]
}


struct Employee: Codable {
    let name: String
    let phone_number: String
    var skills: [String]
}
