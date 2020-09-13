//
//  ListInfoCard.swift
//  Discussion busket
//
//  Created by 18391981 on 13.09.2020.
//

import SwiftUI
import M7Native

struct ListInfoCard: View {
    
    private struct Constans {
        static var textSpasing: CGFloat { return 4 }
    }
    
    var body: some View {
        
        M7Surface(elevation: .z1, background: .primary, padding: .s) {
            
            
            HStack {
                
                Image("user")
                    .frame(width: 48, height: 48)
                    .background(M7Colors.surface.secondary)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: Constans.textSpasing) {
                    
                    HStack {
                        
                        M7Text("Название", style: .subtitle1, color: M7Colors.onSurface.highEmphasis)
                        
                        Spacer()
                        
                        M7Icon(.chevronDown)
                        
                    }
                    
                    
                    M7Text("Описание", style: .caption, color: M7Colors.onBackground.mediumEmphasis)
                }
                
                Spacer()
                
                
            }
            
            
        }
    }
}

struct ListInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        ListInfoCard()
    }
}
