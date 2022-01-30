//
//  SignIn_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 30/1/22.
//

import SwiftUI

struct SignIn_View: View {
    var body: some View {
        ZStack{
            Color.blue.blur(radius: 1000)
            VStack{
                Spacer()
                VStack{
                    
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
