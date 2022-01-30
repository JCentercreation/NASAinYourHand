//
//  APOD_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 12/1/22.
//

import SwiftUI

struct APOD_View: View {
    
    @StateObject var dayImage = DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!))
    
    func getImageInfo() {
        dayImage.getDayImage(completion: { info in
            dayImage.info?.title = info.title
            dayImage.info?.image = info.image
            dayImage.info?.explanation = info.explanation
            dayImage.info?.date = info.date
            print(dayImage.info?.explanation as Any) } )
    }
    
    var body: some View {
        VStack{
            if dayImage.info?.date.isEmpty == false {
                ScrollView {
                    ZStack{
                        Color.blue.blur(radius: 1000)
                        VStack{
                            Text(dayImage.info?.title ?? "")
                                .fontWeight(.bold)
                            Image(uiImage: dayImage.info?.image ?? UIImage(systemName: "photo")!)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            ZStack{
                                Color.blue.cornerRadius(20)
                                VStack{
                                    Text(dayImage.info?.date ?? "")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                    Text(dayImage.info?.explanation ?? "")
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                }
                            }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        }
                    }
                }
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(Color.blue)
                    .scaleEffect(2, anchor: .center)
            }
        }.onAppear {
            self.getImageInfo()
        }
    }
    
}

struct APOD_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id:\.self){ device in
            APOD_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
