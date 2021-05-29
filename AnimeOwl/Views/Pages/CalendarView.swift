//
//  CalendarView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-25.
//

import SwiftUI

struct CalendarView: View {
    
    // Initialize at current date
    @State private var pickerTag = String(DateFormatter()
                                            .weekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1])
    
    @State private var tabSelection = 1
    
    let currentWeekday = DateFormatter()
        .weekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1]
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.init(Color("button"))
    }
    
    var body: some View {
        ZStack {
            BackgroundColour()
            VStack {
                Picker(selection: $pickerTag, label: Text("Picker")) {
                    Text("Mon").tag("Monday")
                    Text("Tue").tag("Tuesday")
                    Text("Wed").tag("Wednesday")
                    Text("Thu").tag("Thursday")
                    Text("Fri").tag("Friday")
                    Text("Sat").tag("Saturday")
                    Text("Sun").tag("Sunday")
                }
                .colorMultiply(Color(.brown))
                .border(Color(.brown), width: 3)
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                TabView(selection: $tabSelection) {
                    ZStack {
                        BackgroundColour()
                        Text("All Upcoming")
                    }
                    .tabItem {
                        VStack {
                            Image(systemName: "book")
                            
                            Text("All Upcoming")
                        }
                    }
                    
                    
                    ZStack {
                        BackgroundColour()
                        Text("Following")
                    }
                    .tabItem {
                        VStack {
                            Image(systemName: "star")
                            
                            Text("Following")
                        }
                    }
                }
            }
        }
        
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
