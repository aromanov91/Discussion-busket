//
//  IOSRootViewModel.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 01.10.2020.
//

import SwiftUI

class iOSRootViewModel: ObservableObject{
    
    public let pageCount: Int = 3
    
    @Published public var currentIndex = 1 {
        didSet {
            hideListButtons()
            hideKeyboardAndEditorTextField()
        }
    }
    
    @Published public var  positionHeight = CGSize.zero
    
    @Published public var isShowMenu = false
    
    @Published public var isShowRate = true
    
    @Published public var isNewItemButtonActive = true
    
    @Published public var listItemsCardPosition: CGSize = .zero
    
    public func menuShowAction() {
        currentIndex = 0
    }
    
    public func listButtonsShowAction() {
        
        if isShowMenu  {

            hideListButtons()

        } else {
            
            showListButtons()
        }
    }
    
    public func hideListButtons() {
        
        listItemsCardPosition.height = .zero
        isShowMenu = false
    }
    
    public func showListButtons() {
        
        listItemsCardPosition.height = 250
        isShowMenu = true
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
