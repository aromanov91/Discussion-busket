//
//  ProVersonBanner.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov  on 13.09.2020.
//

import SwiftUI
import M7Native

struct ProVersonBanner: View {
    var body: some View {
        
        M7Surface(elevation: .z4, background: .primary, padding: .s) {
            VStack(spacing: M7Space.xxs) {
                
                M7Text("Про версия", style: .title3, color: .onSurfaceHighEmphasis, alignment: .center)
                
                M7Text("Получите возможность добавлять больше 2 корзин и более 2 участников", style: .paragraph2, color: .onSurfaceHighEmphasis, alignment: .center)
                
                M7Button(action: { print(print(#function)) }) {
                    Text("Купить")
                }
                
            }
        }
        
    }
}

struct ProVersonBanner_Previews: PreviewProvider {
    static var previews: some View {
        ProVersonBanner()
    }
}
