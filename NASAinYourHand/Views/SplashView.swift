//
//  SplashView.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 11/1/22.
//

import SwiftUI

struct SplashView: View {
    
    @State private var scaleEffectSize: CGFloat = 1
    
    var body: some View {
        VStack(alignment: .center){
            VStack {
                Spacer()
                VStack {
                    Image("AppIcon_logo", bundle: .main)
                        .cornerRadius(20)
                    Text("Space Browser App")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 56 / 255, green: 119 / 255, blue: 237 / 255))
                }.scaleEffect(scaleEffectSize)
                    .animation(.easeInOut(duration: 1), value: scaleEffectSize)
                Spacer()
                Text("JCentercreation© 2022")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 181 / 255, green: 205 / 255, blue: 243 / 255))
            }
        }.onAppear {
            scaleEffectSize += 0.3
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
