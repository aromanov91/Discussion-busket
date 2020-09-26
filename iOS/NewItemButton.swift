//
//  NewItemButton.swift
//  Discussion busket (iOS)
//
//  Created by 18391981 on 26.09.2020.
//

import SwiftUI
import M7Native

struct NewItemButton: View {
    
    let action: () -> Void
    
    private struct Constants {
        
        /// Size
        static var height: CGFloat { return M7Space.xl + M7Space.xxs }
        
        /// Radius
        static var radius: CGFloat { return M7Radius.m }
        
        /// Background
        static var background: Color { return M7Color.surfaceSecondary.color }
        
        /// Font
        static var font: Font { return M7Fonts.button }
    }
    
    @State private var isPressed: Bool = false
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        
        Button(action: action) {
            
            HStack {
                
                M7Icon(.camera,color: .onSurfaceMediumEmphasis)
                
                M7Text("Еще один пункт", style: .button, color: .onSurfaceMediumEmphasis)
                
                Spacer()
                
            }.padding(.horizontal, M7Space.xs)
            .padding(.vertical, M7Space.xxs)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: Constants.height)
            .background(Constants.background)
            .cornerRadius(Constants.radius)
            .font(Constants.font)
            .scaleEffect(self.isPressed ? 0.90 : 1.0)
        }
    }
}

struct NewItemButton_Previews: PreviewProvider {
    static var previews: some View {
        NewItemButton(action: { print(#function)})
    }
}
