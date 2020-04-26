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
        @Binding var task: Task
        var didBecomeFirstResponder = false

        init(text: Binding<String>, isActive: Binding<Bool>, task: Binding<Task>) {
            _text = text
            _isActive = isActive
            _task = task
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.isActive = false
            while (text.last == " ") {
                text.removeLast()
            }
            if (text == "") {
                Services.shared.deleteTask(task: self.task)
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
    @Binding var task: Task
    
    let isCompleted: Bool
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.returnKeyType = UIReturnKeyType.done
        textField.placeholder = "New task..."
        textField.textColor = UIColor(named: TASK_TITLE_NOT_COMPLETED_COLOR)
        textField.setContentCompressionResistancePriority(UILayoutPriority.init(250), for: NSLayoutConstraint.Axis.horizontal)
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text, isActive: $isActive, task: $task)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
