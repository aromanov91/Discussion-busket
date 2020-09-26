//
//  LeftMenu.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov  on 06.09.2020.
//

import SwiftUI
import M7Native

struct LeftMenu: View {
    
    @State var proVersion = false
    
    @State var showProfileView = false
    
    @State var showSettingsView = false
    
    var body: some View {
        
        VStack(spacing: .zero) {
            
            Spacer().frame(height: M7Space.s)
            
            ScrollView {
                
                HStack(spacing: .zero) {

                    VStack(spacing: .zero) {

                        UserProfileButton(firstName: "Alex",
                                          lastName: "Rom",
                                          email: "aromanov07@gmail.com",
                                          action: { showProfileView.toggle() }).sheet(isPresented: $showProfileView, content: {
                                            ProfileView()
                                          })
                        
                        
                        Spacer().frame(height: M7Space.l)
                        
                        ForEach(0..<3) { item in
                            ListInfoCard()
                                .padding(.bottom, M7Space.m)
                        }
                        
                    }
                    
                    Spacer().frame(width: M7Space.m)
                }
                
            }
            
            HStack {
                
                VStack {
                    
                    if !proVersion {
                        
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
