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
                VStack{
                    HStack{
                        Text("hola")
                        Text(dayImage.info?.date ?? "")
                            .font(Font.system(.title, design: .default))
                            .padding(.vertical, 12)
                            .padding(.horizontal, 15)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .cornerRadius(12)
                            .padding(.top, 8)
                        Spacer()
                        Text(dayImage.info?.title ?? "")
                    }
                    Spacer()
                }.background(Image(uiImage: dayImage.info?.image ?? UIImage(systemName: "photo")!)
                                .resizable()
                                .aspectRatio(contentMode: .fill), alignment: .center)
                    .clipped()
                    .ignoresSafeArea()
                
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
    
    func actionSheet(image: UIImage) {
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)

    }
    
}

struct APOD_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone 8"], id:\.self){ device in
            APOD_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
