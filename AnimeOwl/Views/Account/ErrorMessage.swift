//
//  ErrorMessage.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-22.
//

import SwiftUI

struct ErrorMessage: View {
    @Binding var errorMessage: String?
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 50)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .bold()
                    .font(.system(size: 13))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal)
    }
}

struct ErrorMessage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessage(errorMessage: .constant("Error message goes here"))
    }
}
