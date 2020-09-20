//
//  SettingsView.swift
//  Discussion busket (iOS)
//
//  Created by 18391981 on 14.09.2020.
//

import SwiftUI
import M7Native

struct SettingsModelView: View {
    var body: some View {
        
        NavigationView {
            
            List {
                
                Section(header: M7Text("Приложение", style: .overline, color: .onBackgroundMediumEmphasis) ) {
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        M7Row("Оформление", leadingIcon: .grid, size: .s)

                    }
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        M7Row("Уведомления", leadingIcon: .bell, size: .s)
                        
                    }
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        M7Row("Пароль и Face ID", leadingIcon: .lock, size: .s)
                        
                    }
                    
                }
                
                Section(header: M7Text("Settings.SupportSectionTitle", style: .overline, color: .onBackgroundMediumEmphasis) ) {
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        M7Row("Settings.ReviewAppStoreTitle", leadingIcon: .heart, size: .s)

                    }
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        M7Row("Settings.FeedbakToAuthorTitle", leadingIcon: .messageSquare, size: .s)
                        
                    }
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        M7Row("Settings.TelegramChatTitle", leadingIcon: .send, size: .s)
                        
                    }
   
                }
                
                NavigationLink(destination: ProfileView()) {
                    
                    
                    
                    M7Row("Settings.About", leadingIcon: .info, size: .s)
                }
                
            }.navigationBarTitle("Настройки")
            .listStyle(GroupedListStyle())
            
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsModelView()
    }
}
