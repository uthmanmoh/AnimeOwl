//
//  DaysOfWeek.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-29.
//

import Foundation

enum DaysOfWeek: Int, CaseIterable {
    
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var shortForm: String {
        switch self {
        case .monday:       return "Monday"
        case .tuesday:      return "Tuesday"
        case .wednesday:    return "Wednesday"
        case .thursday:     return "Thursday"
        case .friday:       return "Friday"
        case .saturday:     return "Saturday"
        case .sunday:       return "Sunday"
        }
    }
    
}
