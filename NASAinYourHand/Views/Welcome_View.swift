//
//  Welcome_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 12/3/22.
//

import SwiftUI

struct Welcome_View: View {
    
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
        ZStack{
            if let image = dayImage.info?.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            self.getImageInfo()
        }
    }
}

struct Welcome_View_Previews: PreviewProvider {
    static var previews: some View {
        Welcome_View()
    }
}
