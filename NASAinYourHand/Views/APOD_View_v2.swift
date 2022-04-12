//
//  APOD_View_v2.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 13/4/22.
//

import SwiftUI

struct APOD_View_v2: View {
    @StateObject var dayImage = DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!))
    
    @State private var showingSheet: Bool = false
    
    @State var showingIntroductionView = InfoDefaults(alreadyLaunched: false).showIntroductionView()
    
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
                VStack {
                    Image(uiImage: dayImage.info!.image)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.top)
                        .edgesIgnoringSafeArea(.leading)
                        .edgesIgnoringSafeArea(.trailing)
                }.safeAreaInset(edge: .top) {
                    HStack(alignment: .center) {
                        Button {
                            showingSheet.toggle()
                        } label: {
                            Circle()
                                .tint(Color(red: 181 / 255, green: 205 / 255, blue: 243 / 255).opacity(0.8))
                                .frame(width: 40, height: 40, alignment: .center)
                                .overlay(Image(systemName: "note.text")
                                            .scaleEffect(1.5)
                                            .tint(Color(red: 56 / 255, green: 119 / 255, blue: 237 / 255))
                                         )
                        }.sheet(isPresented: $showingSheet) {
                            APOD_Details_View(dayImage: dayImage)
                        }
                        .padding()
                        Spacer()
                        Button {
                            shareSheet(image: dayImage.info!.image)
                        } label: {
                            Circle()
                                .tint(Color(red: 181 / 255, green: 205 / 255, blue: 243 / 255).opacity(0.8))
                                .frame(width: 40, height: 40, alignment: .center)
                                .overlay(Image(systemName: "square.and.arrow.up")
                                            .scaleEffect(1.3)
                                            .tint(Color(red: 56 / 255, green: 119 / 255, blue: 237 / 255))
                                         )
                        }.padding()
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
        .sheet(isPresented: $showingIntroductionView) {
            Introduction_View()
        }
    }
    
    func shareSheet(image: UIImage) {
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)

    }
}

struct APOD_View_v2_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone 8"], id:\.self){ device in
            APOD_View_v2()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
