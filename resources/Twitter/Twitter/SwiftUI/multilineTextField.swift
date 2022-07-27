//
//  multilineTextField.swift
//  Twitter
//
//  Created by Kavsoft on 26/11/19.
//  Copyright © 2019 Kavsoft. All rights reserved.
//

import SwiftUI

// now we going to create multiline Textfield.....

struct multilineTextField : UIViewRepresentable {
    
    
    @Binding var txt : String
    
    func makeCoordinator() -> multilineTextField.Coordinator {
        
        return multilineTextField.Coordinator(parent1 : self)
    }
    func makeUIView(context: UIViewRepresentableContext<multilineTextField>) -> UITextView {
        
        let text = UITextView()
        text.isEditable = true
        text.isUserInteractionEnabled = true
        text.text = "Type Something"
        text.textColor = .gray
        text.font = .systemFont(ofSize: 20)
        text.delegate = context.coordinator
        return text
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<multilineTextField>) {
        
        
    }
    
    class Coordinator : NSObject,UITextViewDelegate{
        
        
        var parent : multilineTextField
        
        init(parent1 : multilineTextField) {
            
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            
            self.parent.txt = textView.text
        }
    }
}
