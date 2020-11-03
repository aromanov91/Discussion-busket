//
//  SwiftUIView.swift
//  Listixs (iOS)
//
//  Created by Alexander Romanov on 30.09.2020.
//

import SwiftUI
import M7Native

struct MsgModel: Codable,Identifiable,Hashable {
    
   //@DocumentID var id : String?
    var id : String?
    var msg : String
    var user : String
    var timeStamp: Date
    
    enum CodingKeys: String,CodingKey {
        case id
        case msg
        case user
        case timeStamp
    }
}



struct ChatRow: View {
    var chatData : MsgModel
    /*@AppStorage("current_user")*/ var user = ""
    var body: some View {
        
        HStack(spacing: M7Space.xSmall){
            
            // NickName View...
            
            if chatData.user != user{
                
                NickName(name: chatData.user)
            }
            
            if chatData.user == user{Spacer(minLength: 0)}
            
            VStack(alignment: chatData.user == user ? .trailing : .leading, spacing: 5, content: {
                
                Text(chatData.msg)
                    .fontWeight(.semibold)
                    .foregroundColor(M7Color.onPrimaryHighEmphasis.color)
                    .padding(.horizontal, M7Space.small)
                    .padding(.vertical, M7Space.small)
                    .background(M7Color.primary.color)
                
                    .clipShape(ChatBubble(myMsg: chatData.user == user))
                
                Text(/*chatData.timeStamp*/"12:20")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(chatData.user != user ? .leading : .trailing , 10)
            })
            
            if chatData.user == user{
                
                NickName(name: chatData.user)
            }
            
            if chatData.user != user{Spacer(minLength: 0)}
        }
        .padding(.horizontal)
        // For SCroll Reader....
        .id(chatData.id)
    }
}

struct NickName : View {
    
    var name : String
    /*@AppStorage("current_user")*/ var user = ""
    
    var body: some View{
        
        Text(String(name.first!))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .frame(width: 24, height: 24)
            .background((name == user ? Color.blue : Color.green))
            .clipShape(Circle())
            // COntext menu For Name Display...
            .contentShape(Circle())
            .contextMenu{
                
                Text(name)
                    .fontWeight(.bold)
            }
    }
}
