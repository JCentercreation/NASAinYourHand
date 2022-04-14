//
//  APOD_PopOvre_View_v3.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 14/4/22.
//

import SwiftUI

struct APOD_PopOver_View_v3: View {
    
    var dayImage: DayImage
    
    var body: some View {
        VStack {
            HStack {
                Text("IMAGE INFO")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(3)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5, style: .circular))
                Spacer()
            }.padding()
            Spacer()
            VStack(alignment: .leading) {
                Text(dayImage.info?.copyright.uppercased() ?? "Copyright")
                    .foregroundColor(.white)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                HStack {
                    Text(dayImage.info?.title ?? "Title")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        shareSheet(image: dayImage.info!.image, description: dayImage.info!.explanation)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                            .scaleEffect(1.3)
                    }
                }.padding(.horizontal)
                Text(dayImage.info?.date.uppercased() ?? "Date")
                    .foregroundColor(.white)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                ScrollView {
                    Text(dayImage.info?.explanation ?? "El Everest es la montaña más alta del planeta Tierra. Se encuentra en la cordillera del Himalaya en el país de Mongolia. Es uno de los destinos turísticos favoritos de los alpinistas. En cuanto al resto para los escaladores hay que decir que no es una de las montañas más altas de afrontar. De hecho es una de las montañas que más escaladores llegan a la cima a lo largo del año.")
                        .foregroundColor(.white)
                        .font(.body)
                }.padding(.horizontal)
                    .frame(maxHeight: 150)
            }
            .background(RoundedRectangle(cornerRadius: 0, style: .continuous).background(.ultraThinMaterial).mask(LinearGradient(gradient: Gradient(colors: [Color.primary, Color.primary, Color.black, Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255), Color.black, Color.black, Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255).opacity(0.88), Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255).opacity(0.75), Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255).opacity(0.5), Color.clear.opacity(0.59)]), startPoint: .bottom, endPoint: .top)))
        }.background(Image(uiImage: dayImage.info!.image).resizable().scaledToFill())
            .cornerRadius(15)
    }
    
    func shareSheet(image: UIImage, description: String) {
        let activityVC = UIActivityViewController(activityItems: [image, description], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
}

struct APOD_PopOver_View_v3_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id: \.self) { device in
            APOD_PopOver_View_v3(dayImage: DayImage(info: Info(resource: "", concept_tags: false, title: "Everest", date: "", media_type: "", explanation: "El Everest es la montaña más alta del planeta Tierra. Se encuentra en la cordillera del Himalaya en el país de Mongolia. Es uno de los destinos turísticos favoritos de los alpinistas. En cuanto al resto para los escaladores hay que decir que no es una de las montañas más altas de afrontar. De hecho es una de las montañas que más escaladores llegan a la cima a lo largo del año.", concepts: "", copyright: "Pepito Perez", service_version: "", image: UIImage(systemName: "photo")!)))
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
