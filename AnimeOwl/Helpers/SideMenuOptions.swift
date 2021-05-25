//
//  SideMenuOptions.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-24.
//

import Foundation

enum SideMenuOptions: Int, CaseIterable {
    
    case home
    case profile
    case search
    case following
    case calendar
    case settings
    case logOut
    
    var title: String {
        switch self {
        case .home:         return "Home"
        case .profile:      return "Profile"
        case .search:       return "Search"
        case .following:    return "Following"
        case .calendar:     return "Calendar"
        case .settings:     return "Settings"
        case .logOut:       return "Log Out"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:         return "house"
        case .profile:      return "person"
        case .search:       return "magnifyingglass"
        case .following:    return "star"
        case .calendar:     return "calendar"
        case .settings:     return "gearshape"
        case .logOut:       return "arrow.left.circle"
        }
    }
    
}
