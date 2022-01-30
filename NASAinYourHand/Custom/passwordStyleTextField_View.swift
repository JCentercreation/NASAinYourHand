//
//  passwordStyleTextField_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 30/1/22.
//

import Foundation
import SwiftUI

struct passwordStyleTextField: View {
    var textField: TextField<Text>
    var secureField: SecureField<Text>?
    var imageName: String
    @State var isSecured: Bool = false
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.darkShadow)
            if isSecured == true {
                secureField
            } else {
                textField
            }
            Button(action: {
                isSecured.toggle()
            }, label: {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
            })
            }
            .padding()
            .foregroundColor(.neumorphictextColor)
            .background(Color.background)
            .cornerRadius(10)
            .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
            .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
            
        }
}
