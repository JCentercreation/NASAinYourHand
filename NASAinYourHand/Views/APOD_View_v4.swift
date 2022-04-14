//
//  APOD_View_v4.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 14/4/22.
//

import SwiftUI

struct APOD_View_v4: View {
    @StateObject var dayImage = DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!))
    
    @State private var showingPopOver: Bool = false
    
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
        VStack {
            if showingPopOver == false {
                HStack {
                    Text(NSLocalizedString("APODView.title", comment: ""))
                        .fontWeight(.bold)
                        .font(Font.title)
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    Spacer()
                }
                HStack(alignment: .top) {
                    Image(uiImage: (dayImage.info?.image ?? UIImage(systemName: "photo"))!)
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: 100)
                        .cornerRadius(15)
                        .onTapGesture {
                            showingPopOver.toggle()
                        }
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(dayImage.info?.title ?? NSLocalizedString("APODView.picture.title.default", comment: ""))
                                .font(.title)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            Text(dayImage.info?.copyright ?? NSLocalizedString("APODView.picture.title.default", comment: ""))
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                    if dayImage.info?.date != nil {
                        VStack(alignment: .center) {
                            Button {
                                shareSheet(image: dayImage.info!.image, description: dayImage.info!.explanation)
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                                    .scaleEffect(1.5)
                                    .padding()
                            }.tint(Color.black)
                        }.padding()
                    }
                }.padding()
                ScrollView {
                    Text(dayImage.info!.explanation)
                        .font(.body)
                }.padding(.horizontal)
                Spacer()
            } else {
                APOD_PopOver_View_v3(dayImage: dayImage)
                    .padding(20)
                    .background(Color.white.opacity(0.3))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showingPopOver.toggle()
                        }
                    }
            }
        }.onAppear {
            self.getImageInfo()
        }
    }
    
    func shareSheet(image: UIImage, description: String) {
        let activityVC = UIActivityViewController(activityItems: [image, description], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }

}

struct APOD_View_v4_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone 8", "iPhone 13"], id: \.self) { device in
            APOD_View_v4()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
