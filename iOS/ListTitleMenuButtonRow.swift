//
//  ListTitleOptionRow.swift
//  Discussion busket
//
//  Created by 18391981 on 13.09.2020.
//

import SwiftUI
import M7Native

struct ListTitleMenuButtonRow: View {

    let icon: M7IconNames
    let title: String
    let rowAction: () -> Void
    let color: Color
    
    private struct Constans {
        static var textSpasing: CGFloat { return M7Space.xs }
    }
    
    public init(icon: M7IconNames, title: String, color: Color = M7Colors.onBackground.highEmphasis, rowAction: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.color = color
        self.rowAction = rowAction
    }
    
    
    var body: some View {
        
        Button(action: rowAction, label: {
           
            M7Icon(icon)
            
            Spacer().frame(width: Constans.textSpasing)
            
            M7Text(title, style: .button, color: color)
            
            Spacer()
        
        })
        
    }
}

struct ListTitleOptionRow_Previews: PreviewProvider {
    static var previews: some View {
        ListTitleMenuButtonRow(icon: .airplay, title: "Memu", color: M7Colors.onSurface.highEmphasis, rowAction: { print() })
            .previewLayout(.sizeThatFits)
            .frame(width: 375.0, height: 80.0)
    }
}
