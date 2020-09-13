//
//  ListMenuButtons.swift
//  Discussion busket (iOS)
//
//  Created by 18391981 on 06.09.2020.
//

import SwiftUI

struct ListMenuButtons: View {
    var body: some View {
       
        VStack {
            
            Button(action: {}, label: {
                Text("Button")
            })
            
            Button(action: {}, label: {
                Text("Button")
            })
            
            Button(action: {}, label: {
                Text("Button")
            })
            
        }
        .padding(.all, 0)
        .frame(minWidth: 0, maxWidth: .infinity)

        
    }
}

struct ListMenuButtons_Previews: PreviewProvider {
    static var previews: some View {
        ListMenuButtons()
    }
}
