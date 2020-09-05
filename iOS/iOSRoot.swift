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
    
    @State var position = CGSize.zero
    
    @GestureState private var translation: CGFloat = 0
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                
                HeadButtons()
                
                HStack {
                
                   
                //LeftMenu()
                    
                    
                ListView()
                    .animation(.interactiveSpring())
                    .offset(x: self.position.width)
                    .gesture(DragGesture()
                                
                                .onChanged{ value in
                                    
                                    self.position = value.translation
                                    
                                    print(value.translation)
                                }
                                
                                .onEnded { value in
                                    if value.translation.width < -geometry.size.width + 100  {
                                        self.position.width = -geometry.size.width + 16
                                        self.currentIndex = 0
                                        
                                        
                                    } else if value.translation.width > geometry.size.width - 100 {
                                        self.position.width = geometry.size.width - 16
                                        self.currentIndex = 2
                                        
                                        
                                        
                                    } else {
                                        self.position = .zero
                                        self.currentIndex = 1
                                    }
                                    
                                    print(value.translation)
                                }
                    )
                    
                   
                    //    ChatView()
                    

            }.ignoresSafeArea(edges: .bottom)
                
            }
            
        }
    }
}


//                .animation(.interactiveSpring())
//                .gesture(
//                    DragGesture().updating(self.$translation) { value, state, _ in
//                        state = value.translation.width
//                    }.onEnded { value in
//                        let offset = value.translation.width / geometry.size.width
//                        let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
//                        self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
//                    }
//                )


struct iOSRoot_Previews: PreviewProvider {
    static var previews: some View {
        iOSRoot()
    }
}
