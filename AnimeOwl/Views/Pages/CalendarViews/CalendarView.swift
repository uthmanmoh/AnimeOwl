//
//  CalendarView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-25.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var model: AnimeModel
    
    // Initialize at current date
    @State private var pickerSelectedDay = String(DateFormatter()
                                                    .weekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1])
    
    @State private var tabSelection = 1
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.init(Color("button"))
        UITabBar.appearance().unselectedItemTintColor = .systemGray
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color(.brown))
    }
    
    var body: some View {
        TabView(selection: $tabSelection) {
            
            ZStack {
                BackgroundColour()
                
                VStack {
                    Picker("", selection: $pickerSelectedDay) {
                        // Picker Items
                        ForEach(DaysOfWeek.allCases, id: \.self) { day in
                            Text(day.shortForm)
                                .tag(day.title)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .overlay(
                        // border around picker
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                    )
                    .padding([.top, .horizontal])
                    
                    
                    if let animes = model.weeklyAnime?.getCurrentDay(forDay: pickerSelectedDay) {
                        CalendarListView(animes: animes)
                    } else {
                        ProgressView()
                        Spacer()
                    }
                }
                
            }
            .tabItem {
                VStack {
                    Image(systemName: "book")
                    
                    Text("Browse Days")
                }
            }
            
            
            
            ZStack {
                BackgroundColour()
                if let animes = model.upcomingAnimes {
                    CalendarListView(animes: animes)
                } else {
                    ProgressView()
                }
            }
            .tabItem {
                VStack {
                    Image(systemName: "clock")
                    
                    Text("View Upcoming")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(Color(#colorLiteral(red: 0.2656752765, green: 0.07812381536, blue: 0.06099386513, alpha: 1)))
        .onAppear {
            model.getWeekdayAnime()
        }
        
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
