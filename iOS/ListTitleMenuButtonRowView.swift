//
//  ListTitleOptionRow.swift
//  Discussion busket
//
//  Created by Alexander Romanov  on 13.09.2020.
//

import SwiftUI
import M7Native

struct ListTitleMenuButtonRowView: View {

    let icon: M7IconNames
    let title: String
    let rowAction: () -> Void
    let color: M7Color
    
    private struct Constans {
        static var textSpasing: CGFloat { return M7Space.xSmall }
    }
    
    public init(icon: M7IconNames, title: String, color: M7Color = .onBackgroundHighEmphasis, rowAction: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.color = color
        self.rowAction = rowAction
    }
    
    
    var body: some View {
        
        Button(action: rowAction, label: {
           
            M7Icon(icon, color: color)
            
            Spacer().frame(width: Constans.textSpasing)
        
            M7Text(title, style: .button, color: color)
            
            Spacer()
        
        })
        
    }
}

struct ListTitleOptionRow_Previews: PreviewProvider {
    static var previews: some View {
        ListTitleMenuButtonRowView(icon: .send, title: "Memu", color: .error, rowAction: { print() })
            .previewLayout(.sizeThatFits)
            .frame(width: 375.0, height: 80.0)
    }
}
