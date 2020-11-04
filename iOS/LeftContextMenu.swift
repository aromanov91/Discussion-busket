//
//  LeftContextMenu.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 03.11.2020.
//

import SwiftUI
import M7Native

struct LeftContextMenu: View {
    
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
        
        VStack {
        
        Button(action: deleteAction, label: {
            HStack {
                M7Text(M7Localize.button.rename, style: .button)
                Spacer()
                M7Icon(.airplay)
            }
        })
            
            Button(action: addUserAction, label: {
                HStack {
                    M7Text(M7Localize.button.add, style: .button)
                    Spacer()
                    M7Icon(.userAdd)
                }
            })
            
            Button(action: historyAction, label: {
                HStack {
                    M7Text(M7Localize.button.done, style: .button)
                    Spacer()
                    M7Icon(.book)
                }
            })
            
            Button(action: deleteAction, label: {
                HStack {
                    M7Text(M7Localize.button.delete, style: .button)
                    Spacer()
                    M7Icon(.trash2)
                }
            })
        
        }
            
//        VStack(spacing: M7Space.large) {
//
//            ListTitleMenuButtonRowView(icon: .newItem, title: "Переименовать", rowAction: renameAction )
//
//            ListTitleMenuButtonRowView(icon: .userAdd, title: "Пригласить", rowAction: renameAction )
//
//            ListTitleMenuButtonRowView(icon: .book, title: "История", rowAction: renameAction)
//
//            ListTitleMenuButtonRowView(icon: .trash2, title: "Удалить", color: .error, rowAction: renameAction )
//
//        }
//        .padding(.all, M7Space.medium)
//        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

//struct LeftContextMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        LeftContextMenu()
//    }
//}
