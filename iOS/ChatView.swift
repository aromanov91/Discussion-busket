//
//  Chat.swift
//  Discussion busket (iOS)
//
//  Created by 18391981 on 06.09.2020.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        
        
        VStack {
        
            Text("Chat")
            
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

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
