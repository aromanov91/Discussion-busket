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
                

                M7AvatarView(firstName: "Алксандр", lastName: "Романов", size: .l)
                
                VStack(spacing: M7Space.xxs) {
                    M7Text("Александр Романов", style: .title3, color: .onBackgroundHighEmphasis)
                    
                    M7Text("aromanov07@gmail.com", style: .paragraph1, color: .onBackgroundMediumEmphasis)
                }
                
                
                M7List(style: .insetGroupedListStyle) {
                    Section {
                        
                        Text("Имя и email")
                        Text("Список контактов")
                        
                    }
                    
                    Section {
                        Button("Выйти") {
                            print("exit")
                        }
                        
                    }
                }

                Spacer()
            }
            
        }.background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
