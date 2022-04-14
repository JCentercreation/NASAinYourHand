//
//  Info_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 13/3/22.
//

import SwiftUI

struct Info_View: View {
    
    @StateObject var infoDefaults = InfoDefaults(alreadyLaunched: false)
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center) {
                Image("AppIcon_logo", bundle: .main)
                    .cornerRadius(20)
                    .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                    .padding()
                Text(NSLocalizedString("InfoView.message", comment: ""))
                    .multilineTextAlignment(.center)
                Link(NSLocalizedString("InfoView.webLink.title", comment: ""), destination: URL(string: "https://www.javiercarrilloblog.com")!)
                    .padding()
            }.padding()
            Spacer()
            Button {
                infoDefaults.resetFirstLaunch()
            } label: {
                Text(NSLocalizedString("InfoView.resetSettings.title", comment: ""))
            }.padding()
        }
    }
}

struct Info_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone 8", "iPhone 13 Pro"], id: \.self) { device in
            Info_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
