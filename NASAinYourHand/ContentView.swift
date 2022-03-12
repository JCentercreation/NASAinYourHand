//
//  ContentView.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 11/1/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        VStack{
            if isActive == true {
                SignIn_View()
            } else {
                Welcome_View()
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id: \.self) { device in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
