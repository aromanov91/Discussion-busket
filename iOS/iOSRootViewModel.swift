//
//  IOSRootViewModel.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 01.10.2020.
//

import SwiftUI

class iOSRootViewModel: ObservableObject{
    
    public let pageCount: Int = 3
    
    @Published public var currentIndex = 1
    
    @Published public var  positionHeight = CGSize.zero
    
    @Published public var isShowMenu = false
    
    @Published public var isNewItemButtonActive = true
    
    @Published public var listItemsCardPosition: CGSize = .zero

    public func menuShowAction() {
        currentIndex = 0
    }
    
    public func listButtonsShowAction() {
        
        if isShowMenu  {

            listItemsCardPosition.height = .zero

            print(0)
            
            //isShowMenu = true

        } else {

            listItemsCardPosition.height = 250

            print(200)
            
            //isShowMenu = false



        }
//
//
//
//        print("listButtonsShowAction")
//
        
        
         isShowMenu.toggle()
        
    }
    
    public func chatShowAction() {
        currentIndex = 2
    }
    
    public func renameAction() {}
    public func addUserAction() {}
    public func historyAction() {}
    public func deleteAction() {}
    
    public func hideKeyboardAndEditorTextField() {
        isNewItemButtonActive = true
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
}
