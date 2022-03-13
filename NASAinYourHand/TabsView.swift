//
//  TabsView.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 11/1/22.
//

import SwiftUI

struct TabsView: View {
    
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor.red
//    }
    
    enum Tab {
        case APOD
        case NeoWs
        case Mars
        case Info
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
                    Label("Asteorids", systemImage: "aqi.medium")
                }
            Asteroids_NeoWs_View()
                .tag(Tab.Mars)
                .tabItem {
                    Label("Mars", systemImage: "globe.asia.australia")
                }
            Asteroids_NeoWs_View()
                .tag(Tab.Info)
                .tabItem {
                    Label("Info", systemImage: "info.circle")
                }
        }.onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(Color.white.opacity(0.1))
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
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
