//
//  ListMenuButtons.swift
//  Discussion busket (iOS)
//
//  Created by 18391981 on 06.09.2020.
//

import SwiftUI
import M7Native

struct ListTitleMenuButtons: View {
    
    let renameAction: () -> Void
    
    let addUserAction: () -> Void
    
    let historyAction: () -> Void
    
    let deleteAction: () -> Void
    
    init(renameAction: @escaping () -> Void,
         addUserAction: @escaping () -> Void,
         historyAction: @escaping () -> Void,
         deleteAction: @escaping () -> Void) {
        
        self.renameAction = renameAction
        self.addUserAction = addUserAction
        self.historyAction = historyAction
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        
        VStack(spacing: M7Space.l) {
           
            ListTitleMenuButtonRow(icon: .type, title: "Переименовать", rowAction: renameAction )
            
            ListTitleMenuButtonRow(icon: .userAdd, title: "Пригласить", rowAction: renameAction )
            
            ListTitleMenuButtonRow(icon: .book, title: "История", rowAction: renameAction )
            
            ListTitleMenuButtonRow(icon: .trash2, title: "Удалить", color: M7Colors.error, rowAction: renameAction )
            
        }
        .padding(.all, M7Space.m)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct ListMenuButtons_Previews: PreviewProvider {
    static var previews: some View {
        ListTitleMenuButtons(renameAction:  { print(#function) },
                             addUserAction: { print(#function) },
                             historyAction: { print(#function) },
                             deleteAction:  { print(#function) })
    }
}
