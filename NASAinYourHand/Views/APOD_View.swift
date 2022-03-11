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
                    VStack{
                        HStack{
                            Text("Picture of the Day")
                                .fontWeight(.bold)
                                .font(Font.title)
                                .foregroundColor(.gray)
                            Spacer()
                        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        ZStack(alignment: .bottomTrailing) {
                            ZStack(alignment: .topLeading) {
                                Image(uiImage: dayImage.info?.image ?? UIImage(systemName: "photo")!)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(20)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                Text(dayImage.info?.title ?? "")
                                    .fontWeight(.bold)
                                    .font(Font.title)
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 10, leading: 35, bottom: 10, trailing: 0))
                            }
                            Text(dayImage.info?.date ?? "")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 35))
                        }
                        VStack{
                            Text(dayImage.info?.explanation ?? "")
                                .foregroundColor(.black)
                                .font(Font.headline)
                                .multilineTextAlignment(.leading)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
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
