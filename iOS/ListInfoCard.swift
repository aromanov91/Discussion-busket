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
            
            
            HStack(spacing: M7Space.xs) {
                
                M7Icon(.user)
                    .frame(width: 48, height: 48)
                    .background(M7Colors.surface.secondary)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: Constans.textSpasing) {
                    
                    HStack {
                        
                        M7Text("Название", style: .subtitle1, color: .onSurfaceHighEmphasis)
                        
                        Spacer()
                        
                        HStack(spacing: -8) {
                            
                            Image("user")
                                .frame(width: 24, height: 24)
                                .background(M7Colors.surface.tertiary)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12)
                                            .stroke(M7Colors.surface.primary, lineWidth: 2))
                            
                            
                            
                            
                            
                            Image("user")
                                .frame(width: 24, height: 24)
                                .background(M7Colors.surface.tertiary)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12)
                                            .stroke(M7Colors.surface.primary, lineWidth: 2))
                            
                            
                            Circle()
                                .frame(width: 24, height: 24)
                                .background(M7Colors.surface.tertiary)
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12)
                                            .stroke(M7Colors.surface.primary, lineWidth: 2))
                            
                            
                        }.offset(x: M7Space.s + M7Space.xxxs)
                        
                    }
                    
                    
                    M7Text("Описание", style: .caption, color: .onSurfaceMediumEmphasis)
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
