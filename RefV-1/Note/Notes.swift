//
//  ListOfSaves.swift
//  RefV-1
//
//

import Foundation
struct Notes: Codable, Identifiable, Equatable {
    var id = UUID()
    var title: String
    var isComplete: Bool  //read info or not
    var date: Date
    var saves: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
