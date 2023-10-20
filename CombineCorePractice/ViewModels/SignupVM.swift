//
//  SignupVM.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import Foundation
import Combine
enum PasswordCheck {
    case valid, invalidLength, noMatch, weakPassword
}

class SignupVM: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var isValid = false
    @Published var usernameMessage = ""
    @Published var passwordMessage = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        
        usernameValidPublisher
            .receive(on: RunLoop.main)
            .map { $0 ? "" : "Username must be at least 6 characters"}
            .assign(to: \.usernameMessage, on: self)
            .store(in: &cancellableSet)
        
        passwordValidPublisher
            .receive(on: RunLoop.main)
            .map { passwordCheck in
                switch passwordCheck {
                    case .invalidLength:
                        return "Password must be at least 8 characters"
                    case .noMatch:
                        return "Passwords do not match"
                    case .weakPassword:
                        return "Password is weak"
                    default:
                        return ""
                }
            }
            .assign(to: \.passwordMessage, on: self)
            .store(in: &cancellableSet)
        
        formValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
}

private extension SignupVM {
    var usernameValidPublisher: AnyPublisher<Bool, Never> {
        $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 5 }
            .eraseToAnyPublisher()
    }
    
    
    var validPasswordLengthPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 8 }
            .eraseToAnyPublisher()
    }
    
    var strongPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map(\.isStrong)
            .eraseToAnyPublisher()
    }
    
    var matchingPasswordsPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .CombineLatest($password, $confirmPassword)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map {
                $0 == $1
            }
            .eraseToAnyPublisher()
    }
    
    var passwordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        Publishers
            .CombineLatest3(validPasswordLengthPublisher, strongPasswordPublisher, matchingPasswordsPublisher)
            .map { validLength, strong, matching in
                if !validLength {
                    return .invalidLength
                }
                
                if !strong {
                    return .weakPassword
                }
                
                if !matching {
                    return .noMatch
                }
                
                return .valid
            }
            .eraseToAnyPublisher()
    }
    
    var formValidPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .CombineLatest(usernameValidPublisher, passwordValidPublisher)
            .map {
                $0 && $1 == .valid
            }
            .eraseToAnyPublisher()
    }
}
