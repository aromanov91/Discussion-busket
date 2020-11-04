//
//  ListView.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov on 05.09.2020.
//

import SwiftUI
import M7Native

struct CenterListView: View {
    
    var isEmpty = false
    
    @GestureState private var draggedOffset: CGSize = .zero
    
    @EnvironmentObject var viewModel: iOSRootViewModel
    
    var body: some View {
            
            VStack(spacing: .zero) {
                
                if isEmpty {
                    
                    VStack(spacing: M7Space.medium) {
                        
                        Image("EmptyList")

                        VStack(spacing: M7Space.xxSmall) {
                            
                            M7Text("Здесь будет ваш список", style: .title2, color: .onSurfaceHighEmphasis, alignment: .center)
                            
                            M7Text("Добавьте ваш первый продукт", style: .paragraph1, color: .onSurfaceHighEmphasis, alignment: .center)
                            
                        }
                        
                    }
                    
                } else {
                    
                    HStack {
                        
                        Capsule().frame(width: 40, height: 4)
                            .foregroundColor(M7Color.surfaceSecondary.color)
                        
                    }.frame(height: 16, alignment: .center)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .gesture(DragGesture()
                                
                        .updating($draggedOffset) { value, state, transaction in
                            state = value.translation
                            
                            self.viewModel.isShowMenu = true
                            
                        }
                        
                        .onEnded { value in
                            
                            if value.translation.height > 100 {
                                
                                self.viewModel.showListButtons()
                                
                            } else {
                                
                                self.viewModel.hideListButtons()
                                
                            }
                        }
                    )
                    
                    
                    List() {
                        
                        //LazyVStack(alignment: .leading, spacing: 8) {
                            
                            ForEach((1...200).reversed(), id: \.self) { item in
                                
                                ListItemRowView("Text")
                                
                            //}
                        }.padding(.all, 20)
                        
                    }
                    
                }
                
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
            .offset(y: viewModel.listItemsCardPosition.height + draggedOffset.height)
            
            
        }

        
        
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CenterListView()
    }
}
