//
//  UserProfileButton.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov  on 07.09.2020.
//

import SwiftUI
import M7Native
import Firebase

struct UserProfileButton: View {
    
    let user: User?
    
    let action: () -> Void
    
    @Binding var authStatus: Bool
    
    private struct Constans {
        static var textSpasing: CGFloat { return 4 }
    }
    
    init(user: User?, authStatus: Binding<Bool> = .constant(true), action: @escaping () -> Void) {
        
        self.user = user
        self.action = action
        self._authStatus = authStatus
    }
    
    var body: some View {
        
        Button(action: action, label: {
            
            HStack {
                
                if authStatus {
                    
                    M7AvatarView(firstName: self.user?.displayName ?? "", size: .m)
                    
                } else {
                    M7Icon(.user)
                        .frame(width: 48, height: 48)
                        .background(M7Colors.surface.secondary)
                        .cornerRadius(24)
                }
                
                VStack(alignment: .leading, spacing: Constans.textSpasing) {
                    
                    M7Text(authStatus
                            ? self.user?.displayName ?? ""
                            : "Авторизация"
                           , style: .subtitle1
                    )
                    
                    M7Text(authStatus
                            ? self.user?.phoneNumber ?? ""
                            : "Войти или зарегистрироваться"
                           , style: .caption, color: .onBackgroundMediumEmphasis)
                }
                
                M7Icon(.chevronDown)
                
                Spacer()
                
            }
        })
    }
}

//struct UserProfileButton_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileButton(firstName: "Ivan", lastName: "Ivanov", email: "mail@mail.com", action: { print(#function) })
//            .previewLayout(.fixed(width: 375.0, height: 100.0))
//    }
//}
