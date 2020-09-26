//
//  Chat.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov  on 06.09.2020.
//

import SwiftUI
import M7Native

struct ChatView: View {
    var body: some View {
        
        
        M7TitleAndButtonView(title: "Обсуждайте списокс друзьями",
                           subtitle: "Отправьте приглашение и делитесь идеями",
                           primaryButtonTitle: "Пригласить",
                           primaryAction: { print("") }).frame(width: 280)
        
//        VStack {
//
//            Text("Chat")
//
//        }
//        .padding(.all, 0)
//        .frame(minWidth: 0, maxWidth: .infinity)
//        .frame(minHeight: 0, maxHeight: .infinity)
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
