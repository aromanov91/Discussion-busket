//
//  ListInfoCard.swift
//  Discussion busket
//
//  Created by Alexander Romanov on 13.09.2020.
//

import SwiftUI
import M7Native

struct ListInfoCard: View {
    
    var name: String
    
    private struct Constans {
        static var textSpasing: CGFloat { return 4 }
    }
    
    var body: some View {
        
        M7Surface(elevation: .z1, background: .primary, padding: .s) {
            
        //M7Background(background: .primary, padding: .s) {
            
            HStack(spacing: M7Space.xs) {
                
                M7Icon(.home)
                    .frame(width: 48, height: 48)
                    .background(M7Colors.surface.secondary)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: Constans.textSpasing) {
                    
                    HStack {
                        
                        M7Text(self.name, style: .subtitle1, color: .onSurfaceHighEmphasis)
                        
                        Spacer()
                        
                        HStack(spacing: -8) {
                            
                            M7AvatarView(size: .s, avatar: Image("userpic"), stroke: true)
                                            .previewDisplayName("Only avatar")
                            
                                        M7AvatarView(firstName: "Jhon", lastName: "Smith", size: .s, stroke: true)
                                            .previewDisplayName("First name, last name and storke")
                            
                                        M7AvatarView(size: .s, avatar: Image("userpic"), stroke: true)
                                            .previewDisplayName("Only avatar")
                            
                            
                        }.offset(x: M7Space.s + M7Space.xxxs)
                        
                    }
                    
                    
                    M7Text("Описание", style: .caption, color: .onSurfaceMediumEmphasis)
                }
                
                Spacer()
                
                
            }
            
            
        }
    }
}

//struct ListInfoCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ListInfoCard()
//    }
//}
