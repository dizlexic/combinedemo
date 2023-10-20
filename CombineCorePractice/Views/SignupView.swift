//
//  SignupView.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import SwiftUI

struct SignupView: View {
    
    @ObservedObject private var signupVM: SignupVM = SignupVM()

    var body: some View {
        ZStack {
            Color.yellow.opacity(0.2)
            VStack(spacing: 24) {
                VStack(alignment: .leading) {
                    Text(signupVM.usernameMessage)
                        .foregroundStyle(.red)
                    TextField("Username", text: $signupVM.username)
                        .custom()
                    
                    Text(signupVM.passwordMessage)
                        .foregroundStyle(.red)
                    SecureField("Password", text: $signupVM.password)
                        .custom()
                    SecureField("Repeat Password", text: $signupVM.confirmPassword)
                        .custom()
                }
                Button {
                    print("successfully registered?")
                } label: {
                    Text("Register")
                        .foregroundStyle(.white)
                        .frame(width: 100, height: 44)
                        .background(signupVM.isValid ? Color.green : Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .disabled(!signupVM.isValid)
            }
            .padding(.horizontal, 24)
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SignupView()
}
