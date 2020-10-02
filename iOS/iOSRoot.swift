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
    
    @ObservedObject private var viewModel = iOSRootViewModel()
    
    var body: some View {
        
        M7ThemingView {
            
            GeometryReader { geometry in
                
                M7ThemingView {
                    
                    ZStack {
                        
                        PagesSliderView(pageCount: viewModel.pageCount, currentIndex: $viewModel.currentIndex) {
                            
                            // Left menu
                            HStack {
                                
                                Spacer().frame(width: M7Space.s + M7Space.m)
                                
                                LeftMenu().padding(.bottom, geometry.safeAreaInsets.bottom)
                                
                            }
                            
                            // Center
                            
                            VStack(spacing: .zero) {
                                
                                ListTitleView(menuAction: { viewModel.menuShowAction(); viewModel.hideKeyboardAndEditorTextField() },
                                              nameAction: { viewModel.listButtonsShowAction() },
                                              chatAction: { viewModel.chatShowAction(); viewModel.hideKeyboardAndEditorTextField() })
                                
                                //if viewModel.isShowMenu {
                                    
                                    
                                    
                                //}
                                
                                ZStack {
                                    
                                    VStack(spacing: .zero) {
                                        
                                        if viewModel.isShowMenu {
                                        
                                        Divider()
                                        
                                        }
                                            
                                        ListTitleMenuButtonsView(renameAction: { viewModel.renameAction() },
                                                                 addUserAction: { viewModel.addUserAction() },
                                                                 historyAction: { viewModel.historyAction() },
                                                                 deleteAction: { viewModel.deleteAction() })
                                        
                                        Spacer()
                                    }
                                    
                                    ListView().environmentObject(viewModel)
                                    
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        NewItemCreateTextFieldView(sendAction: { viewModel.isNewItemButtonActive.toggle() })
                                            .frame(height: 56 + geometry.safeAreaInsets.bottom)
                                    }
                                    
                                    
                                }.frame(maxHeight: viewModel.currentIndex != 1 ? geometry.size.height - M7Space.xxxl : .infinity )
                                
                            }
                            
                            
                            // Right
                            HStack {
                                
                                VStack(spacing: 0) {
                                    
                                    ChatTitleView()
                                    
                                    ZStack {
                                        
                                        ChatView()
                                        
                                        VStack(spacing: 0) {
                                            
                                            Spacer()
                                            
                                            NewItemCreateTextFieldView(sendAction: { viewModel.isNewItemButtonActive.toggle() })
                                                .frame(height: 56 + geometry.safeAreaInsets.bottom)
                                            
                                        }
                                    }
                                    
                                }
                                
                                Spacer().frame(width: M7Space.m - M7Space.xxs )
                                
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
