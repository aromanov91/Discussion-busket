//
//  ListView.swift
//  Discussion busket (iOS)
//
//  Created by 18391981 on 05.09.2020.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        
     
        VStack {
        
            Spacer(minLength: 24)
            List {
                ForEach((1...200).reversed(), id: \.self) { item in
                    Text("Item")
                }
            }
            
        }
        .padding(.all, 0)
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(minHeight: 0, maxHeight: .infinity)
        .background(Color.blue)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.12),
                radius: 16,
                x: 0,
                y: 12)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
