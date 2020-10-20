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
    
    @EnvironmentObject var user: M7UserViewModel
    
    @ObservedObject var leftViewModel = LeftViewModel()
    
    var body: some View {
        
        VStack(spacing: .zero) {
            
            Spacer().frame(height: M7Space.s)
            
            ScrollView {
                
                HStack(spacing: .zero) {
                    
                    VStack(spacing: .zero) {
                        
                        UserProfileButton(firstName: user.info.firstName,
                                          lastName: user.info.lastName,
                                          email: user.info.uid,
                                          authStatus: $auth.status,
                                          action: { showProfileView.toggle() }).sheet(isPresented: $showProfileView, content: {
                                            
                                            
                                            if auth.status {
                                                 ProfileView().environmentObject(user)
                                            } else {
                                            
                                                M7PhoneRegistrationView().environmentObject(auth)
                                            }
                                          })
                        
                        
                        Spacer().frame(height: M7Space.l)
                        
                        ForEach(leftViewModel.userLists) { item in
                            
                            ListInfoCard(name: item.name)
                                .padding(.bottom, M7Space.m)
                                .contextMenu {
                                    Button(action: {
                                        
                                        self.leftViewModel.deleteUserList(id: item.id)
                                        
                                        
//                                        if let index = self.leftViewModel.userLists.firstIndex(of: item) {
//                                            self.leftViewModel.userLists.remove(at: index)
//                                        }
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

