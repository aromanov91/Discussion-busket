//
//  ListView.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov on 05.09.2020.
//

import SwiftUI
import M7Native

struct CenterListView: View {
    
    @GestureState private var draggedOffset: CGSize = .zero
    
    @EnvironmentObject var rootViewModel: iOSRootViewModel
    
    @EnvironmentObject var centerListViewModel: CenterListViewModel
    
    @State var isEditable = false
    
    var body: some View {
        
        if #available(iOS 14.0, *) {
            VStack(spacing: .zero) {
                
                if centerListViewModel.firestoreService.itemRows.isEmpty {
                    
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
                                    
                                    self.rootViewModel.isShowMenu = true
                                    
                                }
                                
                                .onEnded { value in
                                    
                                    if value.translation.height > 100 {
                                        
                                        self.rootViewModel.showListButtons()
                                        
                                    } else {
                                        
                                        self.rootViewModel.hideListButtons()
                                        
                                    }
                                }
                    )
                    
                    
                    List() {
                        
                        //LazyVStack(alignment: .leading, spacing: 8) {
                        
                        ForEach(centerListViewModel.firestoreService.itemRows) { item in
                            
                            ListItemRowView(item.text)
                               
                            
                            //}
                        }
                        .onMove(perform: self.move)
                       // .onMove(perform: centerListViewModel.move())
                        .onLongPressGesture {
                                        withAnimation {
                                            self.isEditable = true
                                        }
                                    }
                        
                        .padding(.all, 20)
                        
                    }.environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
                    
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
            .offset(y: rootViewModel.listItemsCardPosition.height + draggedOffset.height)
            .onAppear() {
                print(centerListViewModel.firestoreService.itemRows)
            }
            .redacted(reason:  centerListViewModel.firestoreService.isLoadData ? .placeholder : .init())
        }
        
        else {
            // Fallback on earlier versions
        }
        
        
    }
    
    func move(from source: IndexSet, to destination: Int) {
        
        centerListViewModel.firestoreService.itemRows.move(fromOffsets: source, toOffset: destination)
        
        
        withAnimation {
                    isEditable = false
                }
        
       }
    
    
    
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CenterListView()
    }
}
