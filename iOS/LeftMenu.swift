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

struct LeftMenu: View {
    
    @State var showProfileView = false
    
    @State var showSettingsView = false
    
    @State var showCreateListView = false
    
    @EnvironmentObject var settings: M7SettingsStore
    
    @EnvironmentObject var auth: M7AuthModel
    
    @EnvironmentObject var authenticationService: AuthenticationService
    
    @ObservedObject var leftViewModel = LeftViewModel()
    
    var body: some View {
        
        VStack(spacing: .zero) {
            
            Spacer().frame(height: M7Space.s)
            
            ScrollView {
                
                HStack(spacing: .zero) {
                    
                    VStack(spacing: .zero) {
                        
                        UserProfileButton(firstName: authenticationService.user.firstName,
                                          lastName: authenticationService.user.lastName,
                                          email: authenticationService.user.uid,
                                          authStatus: $authenticationService.status,
                                          action: { showProfileView.toggle() }).sheet(isPresented: $showProfileView, content: {
                                            
                                            
                                            if auth.status {
                                                 ProfileView().environmentObject(authenticationService)
                                            } else {
                                            
                                                M7PhoneRegistrationView().environmentObject(auth)
                                            }
                                          })
                        
                        
                        Spacer().frame(height: M7Space.l)
                        
                        ForEach(leftViewModel.userLists) { item in
                            
                            ListInfoCard(list: item)
                                .padding(.bottom, M7Space.m)
                                .contextMenu {
                                    Button(action: {
                                        
                                        self.leftViewModel.deleteUserList(item)
                                        
                                        
                                    }, label: {
                                        HStack {
                                            Text("Delete")
                                            Spacer()
                                            Image(systemName: "trash")
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
        }
    }
}

struct LeftMenu_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenu()
    }
}

