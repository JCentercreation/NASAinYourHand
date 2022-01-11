//
//  SplashView.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 11/1/22.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(alignment: .center){
            ZStack{
                Color.blue
                    .blur(radius: 1000)
                    .ignoresSafeArea(.all)
                VStack{
                    VStack{
                        Image("NASA_logo.svg", bundle: .main)
                            .resizable()
                            .scaledToFit()
                    }
                    VStack{
                        Text("Welcome to NASA API data browser")
                            .fontWeight(.bold)
                            .padding()
                        Text("Developed with ❤️ by Javier Carrillo")
                    }.padding()
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id: \.self) { device in
            SplashView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
