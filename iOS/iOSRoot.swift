//
//  MacRoot.swift
//  Discussion busket
//
//  Created by Alexander Romanov  on 05.09.2020.
//

import SwiftUI
import M7Native
import Combine

struct iOSRoot: View {
    
    @ObservedObject private var keyboard = KeyboardResponder()
    
    private let pageCount: Int = 3
    
    @State private var currentIndex = 1
    
    @State private var  positionHeight = CGSize.zero
    
    @GestureState private var translation: CGFloat = 0
    
    @State private var isShowMenu = false
    
    @State private var isNewItemButtonActive = true
    
    var body: some View {
        
        M7ThemingView {
            
            GeometryReader { geometry in
                
                M7ThemingView {
                    
                    ZStack {
                        
                        PagesSliderView(pageCount: pageCount, currentIndex: $currentIndex) {
                            
                            // Left menu
                            HStack {
                                
                                Spacer().frame(width: M7Space.s + M7Space.m)
                                
                                LeftMenu().padding(.bottom, geometry.safeAreaInsets.bottom)
                                
                            }
                            
                            // Center
                            
                            
                            
                            VStack(spacing: .zero) {
                                
                                ListTitleView(menuAction: { menuShowAction(); hideKeyboardAndEditorTextField() },
                                              nameAction: { listButtonsShowAction()},
                                              chatAction: { chatShowAction(); hideKeyboardAndEditorTextField() })
                                
                                if isShowMenu {
                                    
                                    Divider()
                                    
                                    ListTitleMenuButtonsView(renameAction: { renameAction() },
                                                             addUserAction: { addUserAction() },
                                                             historyAction: { historyAction() },
                                                             deleteAction: { deleteAction() })
                                    
                                }
                                
                                ZStack {
                                    
                                    ListView()
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        if isNewItemButtonActive {
                                            
                                            NewItemButton(action: { isNewItemButtonActive.toggle() })
                                                .padding(.horizontal, M7Paddings.all.s)
                                                .padding(.bottom, geometry.safeAreaInsets.bottom + M7Paddings.all.s)
                                            
                                        } else {
                                            
                                            NewItemTextFieldView(sendAction: { hideKeyboardAndEditorTextField()} )
                                                .padding(.bottom, keyboard.currentHeight +
                                                            ( keyboard.currentHeight > 0 ? 0 : geometry.safeAreaInsets.top) )
                                                .animation(.default)
                                            
                                        }
                                    }
                                    
                                    
                                }
                                .frame(maxHeight: currentIndex != 1 ? geometry.size.height - M7Space.xxxl : .infinity )
                                
                            }
                            
                            
                            
                            // Right
                            HStack {
                                
                                Spacer().frame(width: M7Space.m)
                                
                                ChatView()
                                
                                Spacer().frame(width: M7Space.s + M7Space.m)
                                
                            }
                            
                        }
                        .padding(.trailing, geometry.safeAreaInsets.trailing)
                        .padding(.leading, geometry.safeAreaInsets.leading)
                        .padding(.top, geometry.safeAreaInsets.top)
                        .background(Color(UIColor.systemGroupedBackground))
                        
                    }.edgesIgnoringSafeArea(.all)
                    
                }
                
            }
        }
        
    }
    
    private func menuShowAction() {
        
        currentIndex = 0
        print(currentIndex)
    }
    
    private func listButtonsShowAction() {
        
        isShowMenu.toggle()
        
    }
    
    private func chatShowAction() {
        
        currentIndex = 2
        print(currentIndex)
    }
    
    private func hideKeyboardAndEditorTextField() {
        isNewItemButtonActive = true
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
    
    private func renameAction() {}
    private func addUserAction() {}
    private func historyAction() {}
    private func deleteAction() {}
}

struct iOSRoot_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iOSRoot()
                .previewDevice("iPhone X")
            iOSRoot()
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}

final class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0
    
    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}
