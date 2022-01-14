//
//  Asteroids-NeoWs_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 14/1/22.
//

import SwiftUI

struct Asteroids_NeoWs_View: View {
    
    @StateObject var asteroids = Asteroides(infoAsteroid: [])
    
    func asteroidsInfo(){
        asteroids.getAsteorids { asteroides in
            for asteroide in asteroides {
                asteroids.infoAsteroid?.append(asteroide)
                print((asteroide))
            }
        }
    }
    
    var body: some View {
        VStack{
            if asteroids.infoAsteroid?.isEmpty == false {
                List {
                    ForEach(asteroids.infoAsteroid ?? [], id: \.self) { asteroide in
                        VStack{
                            HStack{
                                Text("Name: \(asteroide.name)")
                                Text("Close approach date: \(asteroide.closeApproachDate)")
                                Text("VElocity: \(asteroide.velocity)")
                            }
                            if asteroide.isDanger == true {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            } else {
                Text("Loading Data")
            }
        }.onAppear {
            asteroidsInfo()
        }
    }
}

struct Asteroids_NeoWs_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id: \.self) { device in
            Asteroids_NeoWs_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
