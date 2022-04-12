//
//  APOD_Details_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 12/4/22.
//

import SwiftUI

struct APOD_Details_View: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var dayImage: DayImage
    
    var body: some View {
        VStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.down")
                    .tint(Color.black)
            }
            Spacer()
            if dayImage.info?.date.isEmpty == false {
                VStack{
                    Text("Date: " + dayImage.info!.date)
                    Text("Title: " + dayImage.info!.title)
                }.padding()
                Text(dayImage.info!.explanation)
                    .multilineTextAlignment(.leading)
                Text(dayImage.info!.copyright)
                    .foregroundColor(Color.red)
            } else {
                Text("No hay información para mostrar")
            }
            Spacer()
        }.padding()
    }
}

struct APOD_Details_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id: \.self) { device in
            APOD_Details_View(dayImage: DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!)))
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
