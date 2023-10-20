//
//  SignupViewStyles.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import SwiftUI

struct SignupViewStyles: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 40)
            .background(Color.white)
            .cornerRadius(5.0)
    }
}


extension TextField {
    func custom() -> some View {
        modifier(SignupViewStyles())
            .textInputAutocapitalization(.none)
    }
}

extension SecureField {
    func custom() -> some View {
        modifier(SignupViewStyles())
    }
}
