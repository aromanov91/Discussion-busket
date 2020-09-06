//
//  MacRoot.swift
//  Discussion busket
//
//  Created by 18391981 on 05.09.2020.
//

import SwiftUI

struct iOSRoot: View {
    
    let pageCount: Int = 3
    
    @State var currentIndex = 1
    
    //@State var position = CGSize.zero
    
    @State var  positionHeight = CGSize.zero
    
    @GestureState private var translation: CGFloat = 0
    
    @State var offset: CGFloat = 0
    
    @State var isShowMenu = false
    
    @State var listOffset: CGFloat = -62
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                
                HStack(spacing: 0) {
                    
                    LeftMenu().frame(width: geometry.size.width)
                    
                    VStack {
                        
                        HeadButtons(menuAction: { menuShowAction()},
                                    nameAction: { listButtonsShowAction()},
                                    chatAction: { chatShowAction()})
                        
                        if isShowMenu {
                            
                            ListMenuButtons()
                            
                        }
                        
                        
                        
                        ListView()
                            
                            
                            .frame(width: geometry.size.width)
                        
                        
                        
                    }
                    
                    ChatView().frame(width: geometry.size.width)
                    
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
                .offset(x: self.translation + ( self.currentIndex == 0 ? -16 : self.currentIndex == 2 ? 16 : 0 ))
                .animation(.easeInOut(duration: 0.26))
                .gesture(
                    
                    DragGesture()
                        
                        .updating(self.$translation) { value, state, _ in
                            
                            state = value.translation.width
                            
                        }
                        .onEnded { value in
                            
                            self.offset = value.translation.width / geometry.size.width
                            
                            let newIndex = (CGFloat(self.currentIndex) - self.offset).rounded()
                            
                            self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                            
                            
                        }
                )
                
            }.ignoresSafeArea(edges: .bottom)
            
        }
    }
    
    private func menuShowAction() {
        
        
        currentIndex = 0
        print(currentIndex)
    }
    
    private func listButtonsShowAction() {
        
        isShowMenu.toggle()
        
    }
    
    private func chatShowAction() {
        
        currentIndex = 2
        print(currentIndex)
        
    }
}

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    
    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
        }
    }
}

struct iOSRoot_Previews: PreviewProvider {
    static var previews: some View {
        iOSRoot()
    }
}
