//
//  LeftMenu.swift
//  Discussion busket (iOS)
//
//  Created by 18391981 on 06.09.2020.
//

import SwiftUI

struct LeftMenu: View {
    
    var body: some View {
       
            VStack {
                
                UserProfileButton(firstName: "Alex",
                                  lastName: "Rom",
                                  email: "aromanov07@gmail.com",
                                  action: { print(#function) })
                
                Spacer()
                
            }
            .padding(.all, 0)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            
            
        }
    
}

struct LeftMenu_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenu()
    }
}
