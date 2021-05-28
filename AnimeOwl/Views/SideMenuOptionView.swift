//
//  SideMenuOptionView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-24.
//

import SwiftUI

struct SideMenuOptionView: View {
    var option: SideMenuOptions
    var isCurrent: Bool = false
    
    var body: some View {
        HStack (spacing: 15) {
            Image(systemName: option.imageName)
                .resizable()
                .frame(width: 25, height: 25)
            
            Text(option.title)
                .font(.system(size: 25, weight: .semibold))
            
            Spacer()
        }
        .foregroundColor(Color(.label))
        .padding()
        .background(isCurrent ? Color(.brown) : .clear)
        .animation(.spring(response: 0.1))
        .cornerRadius(25)
    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView(option: .home)
    }
}
