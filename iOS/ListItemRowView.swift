//
//  ListItemRowView.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov on 25.09.2020.
//

import SwiftUI
import M7Native

struct ListItemRowView: View {
    
    let title: String
    let chekboxColor: M7Color = .onBackgroundDisabled
    let textColor: M7Color = .onBackgroundHighEmphasis
    let cursor = false
    
    private struct Constans {
        static var textSpasing: CGFloat { return 20 }
    }
    
    public init(_ title: String /*, rowAction: @escaping () -> Void*/) {
        self.title = title
        //    self.rowAction = rowAction
    }

    var body: some View {
        
        HStack(spacing: Constans.textSpasing, content: {
            
            
            RoundedRectangle(cornerRadius: 6)
                .stroke(chekboxColor.color, lineWidth: 2)
                .frame(width: 16, height: 16)
            
            ZStack(alignment: .leading) {
                
                M7Text(title, style: .subtitle1, color: textColor)
                
                if cursor {
                
                Capsule()
                    .frame(width: 2, height: 20, alignment: .leading)
                    
                }
                
            }
            
            Spacer()
            
            M7AvatarView(firstName: "N", lastName: "F", size: .s)
            
            
        }).padding(.horizontal, 8)
        .padding(.vertical, 6)
    }
}

struct ListItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemRowView("List item")
            .previewLayout(.sizeThatFits)
    }
}
