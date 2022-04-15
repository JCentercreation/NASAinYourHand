//
//  APOD_View_v4.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 14/4/22.
//

import SwiftUI

struct APOD_View_v4: View {
    
    @StateObject var dayImage = DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!))
    
    @StateObject var yesterdayImage = DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!))
    
    @StateObject var preYesterdayImage = DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!))
    
    @StateObject var prePreYesterdayImage = DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!))
    
    @State private var showingPopOver: Bool = false
    
    @State private var sendedDayImage = DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!))
    
    @State var showingIntroductionView = InfoDefaults(alreadyLaunched: false).showIntroductionView()
    
    func getImageInfo() {
        dayImage.getDayImage(completion: { info in
            dayImage.info?.title = info.title
            dayImage.info?.image = info.image
            dayImage.info?.explanation = info.explanation
            dayImage.info?.date = info.date
            print(dayImage.info?.explanation as Any) } )
    }
    
    func getYesterdayImageInfo() {
        yesterdayImage.getImage(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!) { info in
            yesterdayImage.info?.title = info.title
            yesterdayImage.info?.image = info.image
            yesterdayImage.info?.explanation = info.explanation
            yesterdayImage.info?.date = info.date
            print(yesterdayImage.info?.explanation as Any)
        }
    }
    
    func getPreYesterdayImageInfo() {
        preYesterdayImage.getImage(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!) { info in
            preYesterdayImage.info?.title = info.title
            preYesterdayImage.info?.image = info.image
            preYesterdayImage.info?.explanation = info.explanation
            preYesterdayImage.info?.date = info.date
            print(preYesterdayImage.info?.explanation as Any)
        }
    }
    
    func getPrePreYesterdayImageInfo() {
        prePreYesterdayImage.getImage(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!) { info in
            prePreYesterdayImage.info?.title = info.title
            prePreYesterdayImage.info?.image = info.image
            prePreYesterdayImage.info?.explanation = info.explanation
            prePreYesterdayImage.info?.date = info.date
            print(prePreYesterdayImage.info?.explanation as Any)
        }
    }
    
    var body: some View {
        VStack {
            if showingPopOver == false {
                HStack {
                    Text(NSLocalizedString("APODView.title", comment: ""))
                        .fontWeight(.bold)
                        .font(Font.title)
                        .foregroundColor(Color(red: 136 / 255, green: 207 / 255, blue: 139 / 255))
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    Spacer()
                }
                HStack(alignment: .top) {
                    Button {
                        sendedDayImage.info?.title = dayImage.info!.title
                        sendedDayImage.info?.copyright = dayImage.info!.copyright
                        sendedDayImage.info?.date = dayImage.info!.date
                        sendedDayImage.info?.explanation = dayImage.info!.explanation
                        sendedDayImage.info?.image = dayImage.info!.image
                        showingPopOver.toggle()
                    } label: {
                        Image(uiImage: (dayImage.info?.image ?? UIImage(systemName: "photo"))!)
                            .resizable()
                            .frame(maxWidth: 100, maxHeight: 100)
                            .cornerRadius(15)
                    }
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(dayImage.info?.title ?? NSLocalizedString("APODView.picture.title.default", comment: ""))
                                .font(.title)
                                .fontWeight(.bold)
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
                HStack {
                    Text(NSLocalizedString("APODView.secondTitle", comment: ""))
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button {
                            sendedDayImage.info?.title = dayImage.info!.title
                            sendedDayImage.info?.copyright = dayImage.info!.copyright
                            sendedDayImage.info?.date = dayImage.info!.date
                            sendedDayImage.info?.explanation = dayImage.info!.explanation
                            sendedDayImage.info?.image = dayImage.info!.image
                            showingPopOver.toggle()
                        } label: {
                            Image(uiImage: dayImage.info!.image)
                                .frame(maxWidth: 150, maxHeight: 150)
                                .cornerRadius(15)
                        }
                        Button {
                            sendedDayImage.info?.title = yesterdayImage.info!.title
                            sendedDayImage.info?.copyright = yesterdayImage.info!.copyright
                            sendedDayImage.info?.date = yesterdayImage.info!.date
                            sendedDayImage.info?.explanation = yesterdayImage.info!.explanation
                            sendedDayImage.info?.image = yesterdayImage.info!.image
                            showingPopOver.toggle()
                        } label: {
                            Image(uiImage: yesterdayImage.info!.image)
                                .frame(maxWidth: 150, maxHeight: 150)
                                .cornerRadius(15)
                        }
                        Button {
                            sendedDayImage.info?.title = preYesterdayImage.info!.title
                            sendedDayImage.info?.copyright = preYesterdayImage.info!.copyright
                            sendedDayImage.info?.date = preYesterdayImage.info!.date
                            sendedDayImage.info?.explanation = preYesterdayImage.info!.explanation
                            sendedDayImage.info?.image = preYesterdayImage.info!.image
                            showingPopOver.toggle()
                        } label: {
                            Image(uiImage: preYesterdayImage.info!.image)
                                .frame(maxWidth: 150, maxHeight: 150)
                                .cornerRadius(15)
                        }
                        Button {
                            sendedDayImage.info?.title = prePreYesterdayImage.info!.title
                            sendedDayImage.info?.copyright = prePreYesterdayImage.info!.copyright
                            sendedDayImage.info?.date = prePreYesterdayImage.info!.date
                            sendedDayImage.info?.explanation = prePreYesterdayImage.info!.explanation
                            sendedDayImage.info?.image = prePreYesterdayImage.info!.image
                            showingPopOver.toggle()
                        } label: {
                            Image(uiImage: prePreYesterdayImage.info!.image)
                                .frame(maxWidth: 150, maxHeight: 150)
                                .cornerRadius(15)
                        }
                    }
                }.padding(.horizontal)
            Spacer()
            } else {
                APOD_PopOver_View_v3(dayImage: sendedDayImage)
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
            self.getYesterdayImageInfo()
            self.getPreYesterdayImageInfo()
            self.getPrePreYesterdayImageInfo()
        }
        .sheet(isPresented: $showingIntroductionView) {
            Introduction_View()
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
