//
//  HeadButtons.swift
//  Discussion busket
//
//  Created by 18391981 on 30.08.2020.
//

import SwiftUI

struct HeadButtons: View {
    
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
                Image(systemName: "line.horizontal.3").accentColor(Color.black).font(.title2)
            }
            
            Spacer()
            
            Button(action: nameAction) {
                Text("Для дома")
                    .fontWeight(.semibold)
                    .accentColor(Color.black)
                    .font(.title3)
            }
            
            Spacer()
            
            Button(action: chatAction) {
                Image(systemName: "paperplane").accentColor(Color.black).font(.title2)
            }
            
        }.padding()
    }
}

struct HeadButtons_Previews: PreviewProvider {
    static var previews: some View {
        HeadButtons(menuAction: { print(#function)},
                    nameAction: { print(#function)},
                    chatAction: { print(#function)})
    }
}
