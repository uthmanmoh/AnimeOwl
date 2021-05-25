//
//  ProfileView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var model: AnimeModel
    
    var body: some View {
        ZStack {
            BackgroundColour()
            Text("Welcome \(model.user.username)")
                .font(.system(size: 45, weight: .semibold))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
