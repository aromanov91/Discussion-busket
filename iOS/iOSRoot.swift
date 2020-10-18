//
//  MacRoot.swift
//  Discussion busket
//
//  Created by Alexander Romanov  on 05.09.2020.
//

import SwiftUI
import M7Native
import Combine
import Firebase

struct iOSRoot: View {
    
    
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
                                
                                ListTitleView(menuAction: { viewModel.menuShowAction() },
                                              nameAction: { viewModel.listButtonsShowAction() },
                                              chatAction: { viewModel.chatShowAction() })
                                
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
                                    
                                    ListView()
                                        
                                        .environmentObject(viewModel)
                                        .sheet(isPresented: $viewModel.isShowRate) {
                                            M7RateView(image: Image("Rate"))
                                        }
                                    
                                    
                                    VStack {
                                        
                                        Spacer()
                                        
                                        M7MessengerTextFieldView(sendAction: { viewModel.isNewItemButtonActive.toggle() })
                                            .frame(height: 56 + geometry.safeAreaInsets.bottom)
                                            .cornerRadius(12)
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
                                            
                                            M7MessengerTextFieldView(sendAction: { viewModel.isNewItemButtonActive.toggle() })
                                                .frame(height: 56 + geometry.safeAreaInsets.bottom)
                                                
                                            
                                        }
                                    }
                                    
                                }
                                
                                Spacer().frame(width: M7Space.m - M7Space.xxs )
                                
                            }.zIndex(0)
                            
                        }
                        .padding(.trailing, geometry.safeAreaInsets.trailing)
                        .padding(.leading, geometry.safeAreaInsets.leading)
                        .padding(.top, geometry.safeAreaInsets.top)
                        .background(M7Color.backgroundSecondary.color)
//                        .background(Color(UIColor.systemGroupedBackground))
                        
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
