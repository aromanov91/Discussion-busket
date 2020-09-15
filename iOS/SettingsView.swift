//
//  SettingsView.swift
//  Discussion busket (iOS)
//
//  Created by 18391981 on 14.09.2020.
//

import SwiftUI
import M7Native

struct SettingsView: View {
    var body: some View {
        
        NavigationView {
            
            List {
                
                Section(header: M7Text("Приложение", style: .overline) ) {
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        HStack {
                            
                            M7Icon(.grid)
                            
                            Text("Оформление") }
                        
                    }
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        HStack {
                            
                            M7Icon(.bell)
                            
                            Text("Уведомления") }
                        
                    }
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        HStack {
                            
                            M7Icon(.lock)
                            
                            Text("Пароль и Face ID") }
                        
                    }
                    
                }
                
                Section(header: M7Text("Settings.SupportSectionTitle", style: .overline) ) {
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        HStack {
                            
                            M7Icon(.heart)
                            
                            Text("Settings.ReviewAppStoreTitle") }
                        
                    }
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        HStack {
                            
                            M7Icon(.messageSquare)
                            
                            Text("Settings.FeedbakToAuthorTitle") }
                        
                    }
                    
                    NavigationLink(destination: ProfileView()) {
                        
                        HStack {
                            
                            M7Icon(.send)
                            
                            Text("Settings.TelegramChatTitle") }
                        
                    }
                    
                }
                
                NavigationLink(destination: ProfileView()) {
                    
                    HStack {
                        
                        M7Icon(.sliders)
                        
                        Text("О приложении") }
                    
                }
                
            }.navigationBarTitle("Настройки")
            .listStyle(GroupedListStyle())

        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
