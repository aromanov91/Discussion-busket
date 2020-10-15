//
//  UnAuthView.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 15.10.2020.
//

import SwiftUI
import M7Native

struct UnAuthView: View {
    
    private struct Constans {
        static var textSpasing: CGFloat { return 4 }
    }
    
    var body: some View {
        
        M7Surface(elevation: .z1, background: .primary, padding: .s) {
            
        //M7Background(background: .primary, padding: .s) {
            
            HStack(spacing: M7Space.xs) {
                
                M7Icon(.user)
                    .frame(width: 48, height: 48)
                    .background(M7Colors.surface.secondary)
                    .cornerRadius(24)
                
                VStack(alignment: .leading, spacing: Constans.textSpasing) {
                    
                    HStack {
                        
                        M7Text("Авторизация", style: .subtitle1, color: .onSurfaceHighEmphasis)
                        
                        Spacer()
                        
                        
                        
                    }
                    
                    
                    M7Text("Войти или зарегистрироваться", style: .caption, color: .onSurfaceMediumEmphasis)
                }
                
                Spacer()
                
                
            }
            
            
        }
    }
}

struct UnAuthView_Previews: PreviewProvider {
    static var previews: some View {
        UnAuthView()
    }
}
