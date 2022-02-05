//
//  User_model.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 5/2/22.
//

import Foundation

final class UserData: ObservableObject {
    @Published var userEmail: String
    @Published var userPassword: String
    
    init(userEmail: String, userPassword: String) {
        self.userEmail = userEmail
        self.userPassword = userPassword
    }
}


