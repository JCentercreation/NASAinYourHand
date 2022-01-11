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
