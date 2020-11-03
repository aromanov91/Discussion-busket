//
//  ListMenuButtons.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov  on 06.09.2020.
//

import SwiftUI
import M7Native

struct ListTitleMenuButtonsView: View {
    
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
        
        VStack(spacing: M7Space.large) {
           
            ListTitleMenuButtonRowView(icon: .newItem, title: "Переименовать", rowAction: renameAction )
            
            ListTitleMenuButtonRowView(icon: .userAdd, title: "Пригласить", rowAction: renameAction )
            
            ListTitleMenuButtonRowView(icon: .book, title: "История", rowAction: renameAction)
            
            ListTitleMenuButtonRowView(icon: .trash2, title: "Удалить", color: .error, rowAction: renameAction )
            
        }
        .padding(.all, M7Space.medium)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct ListMenuButtons_Previews: PreviewProvider {
    static var previews: some View {
        ListTitleMenuButtonsView(renameAction:  { print(#function) },
                             addUserAction: { print(#function) },
                             historyAction: { print(#function) },
                             deleteAction:  { print(#function) })
    }
}
