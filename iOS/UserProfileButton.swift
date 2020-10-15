//
//  UserProfileButton.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov  on 07.09.2020.
//

import SwiftUI
import M7Native

struct UserProfileButton: View {
    
    let firstName: String
    
    let lastName: String
    
    let email: String
    
    let action: () -> Void
    
    @Binding var authStatus: Bool
    
    private struct Constans {
        static var textSpasing: CGFloat { return 4 }
    }
    
    init(firstName: String, lastName: String, email: String, authStatus: Binding<Bool> = .constant(true), action: @escaping () -> Void) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.action = action
        self._authStatus = authStatus
    }
    
    var body: some View {
        
        Button(action: action, label: {
            
            HStack {
                
                if authStatus {
                
                M7AvatarView(firstName: firstName, lastName: lastName, size: .m)
                    
                } else {
                    M7Icon(.user)
                        .frame(width: 48, height: 48)
                        .background(M7Colors.surface.secondary)
                        .cornerRadius(24)
                }
                
                VStack(alignment: .leading, spacing: Constans.textSpasing) {
                    M7Text(authStatus
                            ? ("\(firstName)" + " " + "\(lastName)")
                        : "Авторизация"
                        , style: .subtitle1
                    )
                    M7Text(authStatus
                        ? email
                        : "Войти или зарегистрироваться"
                        , style: .caption, color: .onBackgroundMediumEmphasis)
                }
                
                
                
                M7Icon(.chevronDown)
                
                Spacer()
                
            }
        })
    }
}

struct UserProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileButton(firstName: "Ivan", lastName: "Ivanov", email: "mail@mail.com", action: { print(#function) })
            .previewLayout(.fixed(width: 375.0, height: 100.0))
    }
}
