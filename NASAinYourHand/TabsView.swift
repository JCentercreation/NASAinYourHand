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
            APOD_View_v4()
                .tag(Tab.APOD)
                .tabItem {
                    Label(NSLocalizedString("TabsView.apodTag.title", comment: ""), systemImage: "photo")
                }
            Asteroids_NeoWs_View()
                .tag(Tab.NeoWs)
                .tabItem {
                    Label(NSLocalizedString("TabsView.asteroidsTag.title", comment: ""), systemImage: "aqi.medium")
                }
            MarsPhotos_View()
                .tag(Tab.Mars)
                .tabItem {
                    Label(NSLocalizedString("TabsView.marsTag.title", comment: ""), systemImage: "globe.asia.australia")
                }
            Info_View()
                .tag(Tab.Info)
                .tabItem {
                    Label(NSLocalizedString("TabsView.infoTag.title", comment: ""), systemImage: "info.circle")
                }
        }.onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(Color(red: 181 / 255, green: 205 / 255, blue: 243 / 255).opacity(0.2))
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .accentColor(Color(red: 56 / 255, green: 119 / 255, blue: 237 / 255))
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
