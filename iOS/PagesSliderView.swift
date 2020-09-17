//
//  SwiftUIView.swift
//  Discussion busket (iOS)
//
//  Created by 18391981 on 07.09.2020.
//

import SwiftUI

struct PagesSliderView<Content: View>: View {
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
            .offset(x: self.translation + ( self.currentIndex == 0 ? -16 : self.currentIndex == 2 ? 16 : 0 ))
            .animation(.easeOut(duration: 0.1))
            .gesture(
                
                DragGesture()
                    
                    .updating(self.$translation) { value, state, _ in
                        
                        state = value.translation.width
                        
                    }
                    .onEnded { value in
                        
                        let offset = value.translation.width / geometry.size.width
                        
                        let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                        
                        self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                        
                        
                    }
            )
        }
    }
}

