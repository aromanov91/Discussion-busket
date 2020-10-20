//
//  CrateNewListView.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 19.10.2020.
//

import SwiftUI
import M7Native

struct CrateNewListView: View {
    
    @Binding var categoryName: String
    
    let action: () -> Void
    
    init(   name: Binding<String>,
                action: @escaping () -> Void
                ) {
        self._categoryName = name
        self.action = action
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Spacer()
                
                M7Button(style: .secondary, size: .m, action: action) {
                    Text("Save")
                }
                
            }
        
        M7Icon(.home)
            .frame(width: 48, height: 48)
            .background(M7Colors.surface.secondary)
            .cornerRadius(12)
            
            M7TextField("Categoty name", text: $categoryName)
            
           
            
        }
    }
}
