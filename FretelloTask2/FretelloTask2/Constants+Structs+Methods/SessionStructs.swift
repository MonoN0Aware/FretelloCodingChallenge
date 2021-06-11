//
//  SessionStructs.swift
//  FretelloTask2
//
//  Created by Decagon on 09/06/2021.
//

import Foundation


struct SessionElement: Codable {
    let name, practicedOnDate: String
    let exercises: [Exercise]
}

struct Exercise: Codable {
    let exerciseID, name: String
    let practicedAtBPM: Int
    
    enum CodingKeys: String, CodingKey {
        case exerciseID = "exerciseId"
        case name
        case practicedAtBPM = "practicedAtBpm"
    }
}

typealias Session = [SessionElement]

