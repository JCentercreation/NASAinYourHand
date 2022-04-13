//
//  APOD_PopOver_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 13/4/22.
//

import SwiftUI

struct APOD_PopOver_View: View {
    
    var dayImage: DayImage
    
    var body: some View {
        List() {
            HStack {
                Spacer()
                Image(systemName: "pip.exit")
            }
            if dayImage.info?.date.isEmpty == false {
                HStack(alignment: .center) {
                    Spacer()
                    VStack{
                        Text(dayImage.info!.date)
                            .fontWeight(.bold)
                        Text(dayImage.info!.title)
                            .fontWeight(.bold)
                    }.padding()
                    Spacer()
                }
                HStack(alignment: .center) {
                    Spacer()
                    Text(dayImage.info!.explanation)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                HStack(alignment: .center) {
                    Spacer()
                    Text(dayImage.info!.copyright + "©")
                        .fontWeight(.bold)
                    Spacer()
                }
            } else {
                Text(NSLocalizedString("APODPopOverView.noInfoMessage.title", comment: ""))
            }
        }.listStyle(.sidebar)
            .cornerRadius(15)
    }
}

struct APOD_PopOver_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id: \.self) { device in
            APOD_PopOver_View(dayImage: DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!)))
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
