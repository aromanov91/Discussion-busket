//
//  Chat.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov  on 06.09.2020.
//

import SwiftUI
import M7Native
import M7NativeFirebase

struct ChatView: View {
    
    @State var showAuthView = false
    
    @State var isEmpty = true
    
    var body: some View {
        
        if isEmpty {
            
            
        M7TitleAndButtonView(title: "Обсуждайте списокс друзьями",
                           subtitle: "Отправьте приглашение и делитесь идеями",
                           image: "EmptyMessages",
                           primaryButtonTitle: "Пригласить",
                           primaryAction: { showAuthView = true }).frame(width: 280)
            .sheet(isPresented: $showAuthView, content: {
                M7AuthView(title: "Состовляйте списки\nс друзьями и храните\nих в облаке", image: Image("Auth"), registrationGoogleAction: { print() } )
            })
        
        
        
        
        } else {
            
            //ScrollViewReader{reader in
                
                ScrollView{
                    
                    VStack(spacing: 15){
                        
                        ForEach(/*homeData.msgs*/ 0..<20){msg in
                            
                            ChatRow(chatData: MsgModel(id: "20", msg: "Message", user: "User", timeStamp: Date()))
//                            .onAppear{
//                                // First Time Scroll
//                                if msg.id == self.homeData.msgs.last!.id && !scrolled{
//
//                                    reader.scrollTo(homeData.msgs.last!.id,anchor: .bottom)
//                                    scrolled = true
//                                }
//                            }
                        }
//                        .onChange(of: homeData.msgs, perform: { value in
//
//                            // You can restrict only for current user scroll....
//                            reader.scrollTo(homeData.msgs.last!.id,anchor: .bottom)
//                        })
                    }
                    
               // }
                }

        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
