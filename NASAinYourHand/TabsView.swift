//
//  TabsView.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 11/1/22.
//

import SwiftUI

struct TabsView: View {
    
    enum Tab {
        case APOD
        case NeoWs
        case Exoplanet
    }
    
    @State private var selection = Tab.APOD
    
    var body: some View {
        TabView(selection: $selection) {
            APOD_View()
                .tag(Tab.APOD)
                .tabItem {
                    Label("APOD", systemImage: "photo")
                }
            Asteroids_NeoWs_View()
                .tag(Tab.NeoWs)
                .tabItem {
                    Label("Asteorids", systemImage: "mosaic")
                }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id:\.self){ device in
            TabsView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
