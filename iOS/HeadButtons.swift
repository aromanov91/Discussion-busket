//
//  HeadButtons.swift
//  Discussion busket
//
//  Created by 18391981 on 30.08.2020.
//

import SwiftUI

struct HeadButtons: View {
    var body: some View {
        HStack {
            
            Button(action: {
                // your action here
            }) {
                Image(systemName: "line.horizontal.3").accentColor(Color.black).font(.title)
            }
            
            Spacer()
            
            Button(action: {
                // your action here
            }) {
                Text("Для дома")
                    .fontWeight(.semibold)
                    .accentColor(Color.black)
                    .font(.title3)
                    
            }
            
            Spacer()
            
            Button(action: {
                // your action here
            }) {
                Image(systemName: "paperplane").accentColor(Color.black)
            }
            
        }.padding()
    }
}

struct HeadButtons_Previews: PreviewProvider {
    static var previews: some View {
        HeadButtons()
    }
}
