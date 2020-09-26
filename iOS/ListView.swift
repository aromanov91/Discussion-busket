//
//  ListView.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov  on 05.09.2020.
//

import SwiftUI

struct ListView: View {
    
    init() {
        if #available(iOS 14.0, *) {} else {
            UITableView.appearance().tableFooterView = UIView()
            UITableView.appearance().separatorStyle = .none
        }
        
    }
    
    var body: some View {
        
        if #available(iOS 14.0, *) {
            
            VStack {
            ScrollView() {
                
                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach((1...200).reversed(), id: \.self) { item in
                        
                        ListItemRowView("Text")
                        
                    }
                }.padding(.all, 20)
                
            }
                
                //NewItemTextFieldView()
            
            }
            .padding(.all, 0)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.12),
                    radius: 16,
                    x: 0,
                    y: 12)
        }
        
        else {
           
            
            ForEach((1...200).reversed(), id: \.self) { item in
                
                ListItemRowView("Text")
                
            }
            .padding(.all, 0)
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.12),
                    radius: 16,
                    x: 0,
                    y: 12)
            
        }
        
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
