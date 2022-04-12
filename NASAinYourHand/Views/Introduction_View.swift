//
//  Introduction_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 12/4/22.
//

import SwiftUI

struct Introduction_View: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Introduction_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id: \.self) { device in
            Introduction_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
