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
            
            Spacer().frame(height: M7Space.small)
            
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
                        
                        
                        Spacer().frame(height: M7Space.large)
                        
                        
                        
                        ForEach(leftViewModel.firestoreService.userLists) { item in
                            
                            ListInfoCard(list: item)
                                .padding(.bottom, M7Space.medium)
                                .contextMenu {
                                    
                                    LeftContextMenu(renameAction: {},
                                                    addUserAction: {},
                                                    historyAction: {},
                                                    deleteAction: { leftViewModel.deleteUserList(item) })
                                    
                                }
                            
                        }
                        
                        M7Button(action: { showCreateListView = true }) {
                            Text(LocalizedStringKey("List.AddList"))
                            
                        }.sheet(isPresented: $showCreateListView) {
                            CrateNewListView(show: $showCreateListView).environmentObject(CrateNewListViewModel())
                        }
                        
                    }
                    
                    Spacer().frame(width: M7Space.medium)
                }
                
            }
            
            HStack {
                
                VStack {
                    
                    if settings.isPro {
                        
                        ProVersonBanner()
                        
                    }
                    
                    ListTitleMenuButtonRowView(icon: .settingsHexagon,
                                               title: M7Localize.settings.title,
                                               color: .onBackgroundHighEmphasis,
                                               rowAction: { showSettingsView.toggle() })
                        .padding(.vertical, M7Space.medium)
                        .sheet(isPresented: $showSettingsView, content: {
                            M7SettingsViews()
                        })
                }
                
                Spacer().frame(width: M7Space.medium)
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

