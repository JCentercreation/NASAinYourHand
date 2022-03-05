//
//  SignUp_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 5/2/22.
//

import SwiftUI
import FirebaseAuth

struct SignUp_View: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var newUserData = UserData(userEmail: "", userPassword: "")
    
    @State private var showEmailPassAlert = false
    
    @State private var showSignUpErrorAlert = false
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack{
            Color.blue.blur(radius: 1000)
            VStack{
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 28 / 255, green: 60 / 255, blue: 140 / 255, opacity: 1))
                    }.frame(alignment: .trailing)
                }
                mailStyleTextField(textField: TextField("Email", text: $newUserData.userEmail), imageName: "person")
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                passwordStyleTextField(textField: TextField("Password", text: $newUserData.userPassword), secureField: SecureField("Password", text: $newUserData.userPassword), imageName: "key", isSecured: false)
                    .autocapitalization(.none)
                Button {
                    if !newUserData.userPassword.isEmpty && !newUserData.userEmail.isEmpty {
                        Auth.auth().createUser(withEmail: newUserData.userEmail, password: newUserData.userPassword) { succerr, error in
                            if error != nil {
                                showAlert = true
                                showSignUpErrorAlert = true
                            }
                        }
                    } else {
                        showAlert = true
                        showEmailPassAlert = true
                    }
                } label: {
                    Text("Sign Up").fontWeight(.bold)
                }.frame(width: 200, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(red: 28 / 255, green: 60 / 255, blue: 140 / 255, opacity: 1))
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
                    .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
                    .alert(isPresented: $showEmailPassAlert){
                        Alert(title: Text("Something went wrong"), message: Text("Please write a proper email and password"), primaryButton: .cancel(Text("Understood")),
                              secondaryButton: .destructive(Text("Cancel")))
                    }
                    .alert(isPresented: $showAlert){
                        if showSignUpErrorAlert == true {
                            return Alert(title: Text("Something went wrong"), message: Text("An error ocurred while signing up"), primaryButton: .cancel(Text("Understood")),
                                  secondaryButton: .destructive(Text("Cancel")))
                        } else if showEmailPassAlert == true {
                            return Alert(title: Text("Something went wrong"), message: Text("Please fill both email and password textfields"), primaryButton: .cancel(Text("Understood")),
                                  secondaryButton: .destructive(Text("Cancel")))
                        } else {
                            return Alert(title: Text("Something went wrong"), message: Text("Please fill both email and password textfields"), primaryButton: .cancel(Text("Understood")),
                                         secondaryButton: .destructive(Text("Cancel")))
                        }
                    }
                Spacer()
            }.padding()
        }
    }
}

struct SignUp_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id: \.self) { device in
            SignUp_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
