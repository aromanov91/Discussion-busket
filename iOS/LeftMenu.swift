//
//  LeftMenu.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov  on 06.09.2020.
//

import SwiftUI
import M7Native
import M7NativeFirebase
import Combine
import M7Private

struct LeftMenu: View {
    
    @State var showProfileView = false
    
    @State var showSettingsView = false
    
    @State var showCreateListView = false
    
    @EnvironmentObject var authenticationService: AuthenticationService
    
    @EnvironmentObject var authenticationFlowViewModel: M7AuthFlowViewModel
    
    @EnvironmentObject var leftViewModel: LeftViewModel
    
    @EnvironmentObject var settings: M7SettingsStore
    
    var body: some View {
        
        VStack(spacing: .zero) {
            
            Spacer().frame(height: M7Space.s)
            
            ScrollView {
                
                HStack(spacing: .zero) {
                    
                    VStack(spacing: .zero) {
                        
                        UserProfileButton(user: authenticationService.currentUser,
                                          authStatus: $authenticationService.status,
                                          action: { showProfileView.toggle() }).sheet(isPresented: $showProfileView, content: {
                                            
                                            
                                            if authenticationService.status {
                                                ProfileView().environmentObject(authenticationService)
                                            } else {
                                                
                                                M7PhoneRegistrationView().environmentObject(authenticationFlowViewModel)
                                            }
                                          })
                        
                        
                        Spacer().frame(height: M7Space.l)
                        
                        ForEach(leftViewModel.firestoreService.userLists) { item in
                            
                            ListInfoCard(list: item)
                                .padding(.bottom, M7Space.m)
                                .contextMenu {
                                    Button(action: { self.leftViewModel.deleteUserList(item)
                                    }, label: {
                                        HStack {
                                            M7Text(M7Localize.button.delete, style: .button)
                                            Spacer()
                                            M7Icon(.trash2)
                                        }
                                    })
                                }
                            
                        }
                        
                        M7Button(action: { showCreateListView = true }) {
                            Text("Create list")
                            
                        }.sheet(isPresented: $showCreateListView) {
                            CrateNewListView(name: $leftViewModel.listName, action: leftViewModel.createList)
                        }
                        
                    }
                    
                    Spacer().frame(width: M7Space.m)
                }
                
            }
            
            HStack {
                
                VStack {
                    
                    if settings.isPro {
                        
                        ProVersonBanner()
                        
                    }
                    
                    ListTitleMenuButtonRowView(icon: .settingsHexagon,
                                               title: "Настройки",
                                               color: .onBackgroundHighEmphasis,
                                               rowAction: { showSettingsView.toggle() })
                        .padding(.vertical, M7Space.m)
                        .sheet(isPresented: $showSettingsView, content: {
                            M7SettingsViews()
                        })
                }
                
                Spacer().frame(width: M7Space.m)
            }
        }//.toast(isShowing: $showCreateListView, text: Text("Hello toast!"))
        //        .alertX(isPresented: $showCreateListView, content: {
        //
        //
        //
        //
        //                        })
        //        .m7alert(isPresented: $showCreateListView) {
        //
        //            M7Alert(title: "Получилось", image: getM7Image(.folder), autohide: true)
        //        }
    }
}

struct LeftMenu_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenu()
    }
}

