//
//  CustomTextFieldView.swift
//  Tasks
//
//  Created by Paul Thorsen on 1/3/20.
//  Copyright © 2020 Paul Thorsen. All rights reserved.
//

import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        @Binding var isActive: Bool
        var didBecomeFirstResponder = false

        init(text: Binding<String>, isActive: Binding<Bool>) {
            _text = text
            _isActive = isActive
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.isActive = false
            while (text.last == " ") {
                text.removeLast()
            }
            
            if (text == "") {
                // Delete this item
            }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.isActive = true
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    @Binding var isActive: Bool
    let isCompleted: Bool
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        // change UITextField text to white and black based on completion status
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.returnKeyType = UIReturnKeyType.done
        textField.placeholder = "New Task..."
        textField.textColor = UIColor(named: TASK_TITLE_NOT_COMPLETED_COLOR)
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text, isActive: $isActive)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

struct CustomTextFieldView: View {
    @State var text: String = ""
    @State var isActive: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            CustomTextField(text: self.$text, isActive: self.$isActive, isCompleted: false, isFirstResponder: true)
                .frame(width: 300, height: 50)
                .background(Color.red)
        }
    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView()
    }
}
