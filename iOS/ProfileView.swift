//
//  ProfileView.swift
//  Discussion busket (iOS)
//
//  Created by 18391981 on 13.09.2020.
//

import SwiftUI
import M7Native

struct ProfileView: View {
    var body: some View {
        
        ZStack {
            
            VStack(spacing: M7Space.m) {
                
                Spacer().frame(height: M7Space.xl)
                
                Image("user")
                    .frame(width: 96, height: 96)
                    .background(M7Colors.surface.tertiary)
                    .cornerRadius(48)
                
                VStack(spacing: M7Space.xxs) {
                    M7Text("Александр Романов", style: .title3, color: .onBackgroundHighEmphasis)
                    
                    M7Text("aromanov07@gmail.com", style: .paragraph1, color: .onBackgroundMediumEmphasis)
                }
                
                
                List {
                    
                    Section {
                        
                        Text("Имя и email")
                        Text("Список контактов")
                        
                    }
                    
                    Section {
                        Button("Выйти") {
                            print("exit")
                        }
                        
                    }
                }.listStyle(InsetGroupedListStyle())
                
                Spacer()
            }
            
        }.background(Color(UIColor.systemGroupedBackground))
        .ignoresSafeArea(edges: .bottom)
    
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
