//
//  MacRoot.swift
//  Discussion busket
//
//  Created by 18391981 on 05.09.2020.
//

import SwiftUI
import M7Native

struct iOSRoot: View {
    
    let pageCount: Int = 3
    
    @State var currentIndex = 1
    
    @State var  positionHeight = CGSize.zero
    
    @GestureState private var translation: CGFloat = 0
    
    @State var isShowMenu = false
    
   
    
    
    var body: some View {
        
        M7ThemingView {
        
        GeometryReader { geometry in
            
            M7ThemingView {
            
            ZStack {
                
                PagesSliderView(pageCount: pageCount, currentIndex: $currentIndex) {
                    
                    HStack {
                        
                        Spacer().frame(width: M7Space.s + M7Space.m)
                        
                        LeftMenu().padding(.bottom, geometry.safeAreaInsets.bottom)
                        
                    }
                    
                    VStack(spacing: .zero) {
                        
                        ListTitle(menuAction: { menuShowAction()},
                                  nameAction: { listButtonsShowAction()},
                                  chatAction: { chatShowAction()})
                        
                        if isShowMenu {
                            
                            Divider()
                            
                            ListTitleMenuButtons(renameAction: { renameAction() },
                                                 addUserAction: { addUserAction() },
                                                 historyAction: { historyAction() },
                                                 deleteAction: { deleteAction() })
                            
                        }
                        
                        ListView()
                            .frame(maxHeight: currentIndex != 1 ? geometry.size.height - M7Space.xxxl : .infinity )
                        
                    }
                    
                    HStack {
                        
                        Spacer().frame(width: M7Space.m)
                        
                        ChatView()
                        
                        Spacer().frame(width: M7Space.s + M7Space.m)
                        
                    }
                    
                }
                .padding(.trailing, geometry.safeAreaInsets.trailing)
                .padding(.leading, geometry.safeAreaInsets.leading)
                .padding(.top, geometry.safeAreaInsets.top)
                .background(Color(UIColor.systemGroupedBackground))
                
            }.edgesIgnoringSafeArea(.all)

            }
            
        }
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
    
    private func renameAction() {}
    private func addUserAction() {}
    private func historyAction() {}
    private func deleteAction() {}
}

struct iOSRoot_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            iOSRoot()
                .previewDevice("iPhone X")
            iOSRoot()
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
