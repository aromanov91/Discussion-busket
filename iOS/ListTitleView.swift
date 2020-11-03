//
//  HeadButtons.swift
//  Discussion busket
//
//  Created by Alexander Romanov  on 30.08.2020.
//

import SwiftUI
import M7Native

struct ListTitleView: View {
    
    let menuAction: () -> Void
    
    let nameAction: () -> Void
    
    let chatAction: () -> Void
    
    public init(menuAction: @escaping () -> Void,
                nameAction: @escaping () -> Void,
                chatAction: @escaping () -> Void) {
        
        self.menuAction = menuAction
        self.nameAction = nameAction
        self.chatAction = chatAction
        
    }
    
    var body: some View {
        
        HStack {
            
            Button(action: menuAction) {
                M7Icon(.menuLine2)
            }
            
            Spacer()
            
            Button(action: nameAction) {
                M7Text("Для дома", style: .title3).accentColor(M7Colors.onBackground.highEmphasis)
            }
            
            
            Spacer()
            
            Button(action: chatAction) {
                M7Icon(.send)
            }
            
        }.padding(.all, M7Space.medium)
    }
}

struct HeadButtons_Previews: PreviewProvider {
    static var previews: some View {
        ListTitleView(menuAction: { print(#function)},
                    nameAction: { print(#function)},
                    chatAction: { print(#function)})
    }
}
