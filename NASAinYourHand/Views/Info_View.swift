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
        Button {
            infoDefaults.resetFirstLaunch()
        } label: {
            Text("Resetea los ajustes de usuario")
        }

    }
}

struct Info_View_Previews: PreviewProvider {
    static var previews: some View {
        Info_View()
    }
}
