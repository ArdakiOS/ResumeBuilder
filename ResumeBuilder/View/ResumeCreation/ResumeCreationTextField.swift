//
//  ResumeCreationTextField.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//

import SwiftUI
struct ResumeCreationTextField : View {
    @Binding var text : String
    let prompt : Text
    var body: some View {
        HStack{
            TextField("", text: $text, prompt: prompt.font(.system(size: 20, weight: .semibold)).foregroundColor(Color(hex: "#444444").opacity(0.30)))
        }
        .font(.system(size: 18, weight: .regular))
        .padding(.horizontal, 15)
        .padding(.vertical, 20)
        .background(Color(hex:"#F8FBFF"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
