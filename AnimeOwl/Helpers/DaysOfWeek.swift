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
    
    var title: String {
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
    
    var shortForm: String {
        switch self {
        case .monday:       return "Mon"
        case .tuesday:      return "Tue"
        case .wednesday:    return "Wed"
        case .thursday:     return "Thu"
        case .friday:       return "Fri"
        case .saturday:     return "Sat"
        case .sunday:       return "Sun"
        }
    }
    
}
