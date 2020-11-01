//
//  ChatTitleView.swift
//  Listixs (iOS)
//
//  Created by Alexander Romanov on 01.10.2020.
//

import SwiftUI
import M7Native

struct ChatTitleView: View {
    var body: some View {
        
        HStack(alignment: .center) {
            
            VStack(alignment: .leading, spacing: M7Space.xxxs) {
                
                M7Text("Messages", style: .title3, color: .onBackgroundMediumEmphasis)
                
                M7Text("5 участников, 2 в сети", style: .caption, color: .onBackgroundDisabled)
                
            }
            
            Spacer()
            
            M7AvatarView(firstName: "A", size: .s)
            
        }.padding(.horizontal, M7Paddings.all.s)
        .padding(.vertical, M7Space.xxs)
        
    }
}

struct ChatTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ChatTitleView()
    }
}
