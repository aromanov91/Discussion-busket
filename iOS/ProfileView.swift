//
//  ProfileView.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov on 13.09.2020.
//

import SwiftUI
import M7Native
import M7NativeFirebase

struct ProfileView: View {
    
    @EnvironmentObject var auth: M7AuthFlowViewModel
    
    @EnvironmentObject var authenticationService: AuthenticationService
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: M7Space.medium) {
                
                Spacer().frame(height: M7Space.xLarge)
                
                
                M7AvatarView(firstName: authenticationService.currentUser?.displayName ?? "", size: .l)
                
                VStack(spacing: M7Space.xxSmall) {
                    
                    M7Text(authenticationService.currentUser?.displayName ?? "", style: .title3, color: .onBackgroundHighEmphasis)
                    
                    M7Text( authenticationService.currentUser?.phoneNumber ?? "", style: .paragraph1, color: .onBackgroundMediumEmphasis)
                }
                
                
                M7List(style: .insetGroupedListStyle) {
                    Section {
                        
                        Text("Profile.NameAndPhone")
                        Text("Profile.Contacts")
                        
                    }
                    
                  Section {
//                        M7Button() {
//                            print("exit")
//
//
//                        }
                        
                    M7Button(style: .link, size: .m, action: { auth.logOut() }) {
                            M7Text(M7Localize.button.exit, style: .button, color: .error)
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
