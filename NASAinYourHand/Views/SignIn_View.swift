//
//  SignIn_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 30/1/22.
//

import SwiftUI

struct SignIn_View: View {
    
    @State private var isAuthorized: Bool = false
    
    @StateObject private var userData = UserData(userEmail: "", userPassword: "")
    
    private var buttonText = "Sign In"
    
    @State private var offset: CGFloat = 200.0
    
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
                                isAuthorized.toggle()
                            } label: {
                                Text("Sign In").fontWeight(.bold)
                            }.frame(width: 200, height: 50, alignment: .center)
                                .foregroundColor(.white)
                                .background(Color(red: 28 / 255, green: 60 / 255, blue: 140 / 255, opacity: 1))
                                .cornerRadius(10)
                                .aspectRatio(contentMode: .fit)
                                .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
                                .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)

                        }
                        Spacer()
                    }
                } else {
                    TabsView().transition(.asymmetric(insertion: .scale, removal: .opacity))
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
