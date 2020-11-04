//
//  ListInfoCard.swift
//  Discussion busket
//
//  Created by Alexander Romanov on 13.09.2020.
//

import SwiftUI
import M7Native

struct ListInfoCard: View {
    
    var list: UserListModel
    
    @State var listItem = ListModel(id: "Load", name: "Load", icon: "Load", owner: "Load")
    
    @EnvironmentObject var leftViewModel: LeftViewModel
    
    @State private var isLoad: Bool = true
    
    private struct Constans {
        static var textSpasing: CGFloat { return 4 }
    }
    
    var body: some View {
        
        M7Surface(elevation: .z1, background: .primary, padding: .s) {
            
        //M7Background(background: .primary, padding: .s) {
            
            HStack(spacing: M7Space.xSmall) {
                
                M7Icon(M7IconNames(rawValue: list.icon) ?? .none)
                    .frame(width: 48, height: 48)
                    .background(M7Colors.surface.secondary)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: Constans.textSpasing) {
                    
                    HStack {
                        
                        M7Text(listItem.name, style: .subtitle1, color: .onSurfaceHighEmphasis, placeholder: $isLoad)
                        
                        Spacer()
                        
                        HStack(spacing: -8) {
                            
                            M7AvatarView(size: .s, avatar: Image("userpic"), stroke: true)
                                            .previewDisplayName("Only avatar")
                            
                                        M7AvatarView(firstName: "Jhon", lastName: "Smith", size: .s, stroke: true)
                                            .previewDisplayName("First name, last name and storke")
                            
                                        M7AvatarView(size: .s, avatar: Image("userpic"), stroke: true)
                                            .previewDisplayName("Only avatar")
                            
                            
                        }.offset(x: M7Space.small + M7Space.xxxSmall)
                        
                    }
                    
                    
                    M7Text(listItem.owner, style: .caption, color: .onSurfaceMediumEmphasis, placeholder: $isLoad)
                }
                
                Spacer()
                
                
            }
            
            
        }.onAppear() {
            
            let _ = leftViewModel.getListData(userList: list) { listn in
                listItem = listn
                isLoad = false
            }
            
            
            
            
        }
    }
}

