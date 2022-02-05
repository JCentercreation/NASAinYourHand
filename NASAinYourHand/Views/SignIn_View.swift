//
//  SignIn_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 30/1/22.
//

import SwiftUI
import FirebaseAuth

struct SignIn_View: View {
    
    @State private var isAuthorized: Bool = false
    
    @StateObject private var userData = UserData(userEmail: "", userPassword: "")
    
    private var buttonText = "Sign In"
    
    @State private var showSignInErrorAlert = false
    
    @State private var showEmailPassAlert = false
    
    @State private var showSignUpModal = false
    
    var body: some View {
        ZStack{
            Color.blue.blur(radius: 1000)
            VStack {
                if isAuthorized == false {
                    VStack{
                        Image("NASA_logo.svg", bundle: .main)
                            .resizable()
                            .scaledToFit()
                            .offset(x: 10, y: 0)
                        VStack{
                            mailStyleTextField(textField: TextField("Email", text: $userData.userEmail), imageName: "person")
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                            passwordStyleTextField(textField: TextField("Password", text: $userData.userPassword), secureField: SecureField("Password", text: $userData.userPassword), imageName: "key", isSecured: false)
                                .autocapitalization(.none)
                        }.padding()
                        VStack{
                            Button {
                                if !userData.userPassword.isEmpty && !userData.userEmail.isEmpty {
                                    Auth.auth().signIn(withEmail: userData.userEmail, password: userData.userPassword) { signInSuccess, signInError in
                                        if signInError != nil {
                                            showSignInErrorAlert = true
                                        } else {
                                            isAuthorized = true
                                        }
                                    }
                                } else {
                                    showEmailPassAlert = true
                                }
                            } label: {
                                Text("Sign In").fontWeight(.bold)
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
                                .alert(isPresented: $showSignInErrorAlert){
                                    Alert(title: Text("Did not sign in"), message: Text("The email or the password is not valid"), primaryButton: .cancel(Text("Understood")),
                                          secondaryButton: .destructive(Text("Cancel")))
                                }
                                .padding()
                            Button {
                                showSignUpModal = true
                            } label: {
                                Text("Sign Up").fontWeight(.bold)
                            }.foregroundColor(Color(red: 28 / 255, green: 60 / 255, blue: 140 / 255, opacity: 1))
                                .cornerRadius(10)
                                .aspectRatio(contentMode: .fit)
                                .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
                                .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
                                .sheet(isPresented: $showSignUpModal) {
                                    print("")
                                } content: {
                                    SignUp_View()
                                }

                        }
                        Spacer()
                    }
                } else {
                    TabsView()
                }
            }
        }
    }
}

struct SignIn_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id: \.self) { device in
            SignIn_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
