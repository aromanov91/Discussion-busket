//
//  SwiftUIView.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 01.10.2020.
//

import SwiftUI
import M7Native

struct NewItemCreateTextFieldView: View {
    
    @State var text = ""
    @State private var focused: Bool = true
    
    
    let sendAction: () -> Void
    
    public init(sendAction: @escaping () -> Void) {
        self.sendAction = sendAction
    }
    
    
    var body: some View {
        
        
        
        HStack(alignment: .top) {
            
            ZStack {
                
                BlurView(style: .light)
                
                VStack {
                    
                    HStack(spacing: M7Space.s) {
                        
                        Button(action: sendAction ) {
                            M7Icon(.camera)
                        }
                        
                        
                        TextField("New message", text:  $text)
                            .frame(height: 40)
                            .textFieldStyle(PlainTextFieldStyle())
                            .cornerRadius(16)
                        
                        Button(action: sendAction ) {
                            M7Icon(.arrowUp)
                        }
                        
                        
                    }.frame(height: 40)
                    .padding(.leading, 12)
                    .padding(.trailing, 8)
                    
                    .background(M7Color.onBackgroundHighEmphasis.color.opacity(0.07))
                    .cornerRadius(14)
                    
                    Spacer()
                    
                }
                .padding(.horizontal, M7Space.xs)
                .padding(.vertical, M7Space.xxs)
                
               
                
                
            }
        }
        .padding(.all, 0)
        .frame(minWidth: 0, maxWidth: .infinity)
        
        //.background(Color(UIColor.systemBackground))

        
        
    }
}

struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
        
    }
    
}
