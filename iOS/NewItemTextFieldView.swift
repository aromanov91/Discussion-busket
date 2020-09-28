//
//  NewItemTextFieldView.swift
//  Discussion busket (iOS)
//
//  Created by Alexander Romanov on 25.09.2020.
//

import SwiftUI
import M7Native

struct NewItemTextFieldView: View {
    
    @State var text = ""
    @State private var focused: Bool = true
 
    
    let sendAction: () -> Void
    
    public init(sendAction: @escaping () -> Void) {
        self.sendAction = sendAction
    }
    
    
    var body: some View {
        
        HStack {
            
            HStack(spacing: M7Space.s) {
                
                Button(action: sendAction ) {
                    M7Icon(.camera)
                }

                CustomTextField(text: $text, isFirstResponder: true)
                
                Button(action: sendAction ) {
                    M7Icon(.arrowUp)
                }

            }.padding(.horizontal, M7Paddings.all.m)
        }
        .padding(.all, 0)
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 56)
        .background(Color(UIColor.systemBackground))
        .shadow(color: Color.black.opacity(0.12),
                radius: 16,
                x: 0,
                y: 12)
    }
}

struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                if let nextTextField = textField.superview?.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                    nextTextField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
                return false
            }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}




struct NewItemTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemTextFieldView(sendAction: {print(#function)} )
    }
}
