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
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.init(Color("button"))
        UITabBar.appearance().unselectedItemTintColor = .systemGray
    }
    
    var body: some View {
        TabView(selection: $tabSelection) {
            
            ZStack {
                BackgroundColour()
                ZStack {
                    
                    ScrollView(showsIndicators: false) {
                        if let animes = model.weeklyAnime?.getCurrentDay(forDay: pickerSelectedDay) {
                            LazyVGrid (columns: gridItems) {
                                ForEach(animes.sorted(by: { first, second in
                                    first.score ?? 0 > second.score ?? 0
                                })) { anime in
                                    CalendarAnimeCard(anime: anime)
                                }
                            }
                            .padding(.horizontal)
                        } else {
                            ProgressView()
                        }
                    }
                    
                    Picker(selection: $pickerSelectedDay, label:
                            Text(pickerSelectedDay)
                            .font(Font.custom("Avenir Heavy", size: 18))
                            .foregroundColor(Color(.label))
                            .padding(10)
                            .background(Color("button"))
                            .cornerRadius(20.0, antialiased: true)
                            .shadow(color: .black, radius: 20, y: 5)
                            .shadow(color: .black, radius: 20, y: 5)
                    ) {
                        // Picker Items
                        ForEach(DaysOfWeek.allCases, id: \.self) { day in
                            Text(day.shortForm)
                                .tag(day.shortForm)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .offset(y: -15)
                    .frame(maxHeight: .infinity, alignment: .top)
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
                Text("Following")
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
        //            .overlay(Picker(selection: $pickerSelectedDay, label:
        //                                Text(pickerSelectedDay)
        //                                .font(Font.custom("Avenir Heavy", size: 18))
        //                                .foregroundColor(Color(.label))
        //                                .padding(10)
        //                                .background(Color(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)))
        //                                .cornerRadius(25.0)
        //                                .shadow(color: .black.opacity(0.8), radius: 15, x: -5, y: 5)
        //            ) {
        //                // Picker Items
        //                ForEach(DaysOfWeek.allCases, id: \.self) { day in
        //                    Text(day.shortForm)
        //                        .tag(day.shortForm)
        //                }
        //            }
        //            .pickerStyle(MenuPickerStyle()), alignment: .topTrailing)
        
        .onAppear {
            model.getWeekdayAnime()
        }
//        .onChange(of: pickerSelectedDay, perform: { _ in
//            model.getWeekdayAnime(forDay: pickerSelectedDay)
//        })
        
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
