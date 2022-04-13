//
//  APOD_View_v3.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 13/4/22.
//

import SwiftUI

struct APOD_View_v3: View {
    @StateObject var dayImage = DayImage(info: Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "photo")!))
    
    @State private var showingSheet: Bool = false
    
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
        VStack{
            if dayImage.info?.date.isEmpty == false {
                if showingPopOver == false {
                    VStack {
                        Image(uiImage: dayImage.info!.image)
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.top)
                            .edgesIgnoringSafeArea(.leading)
                            .edgesIgnoringSafeArea(.trailing)
                    }.safeAreaInset(edge: .top) {
                        HStack(alignment: .center, spacing: 0) {
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showingPopOver.toggle()
                                }
                            } label: {
                                Image(systemName: "note.text")
                                    .padding(8)
                                    
                            }.sheet(isPresented: $showingSheet) {
                                APOD_Details_View(dayImage: dayImage)
                            }
                            Divider()
                                .frame(maxHeight: 30)
                            Button {
                                shareSheet(image: dayImage.info!.image)
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                                    .padding(8)
                                    
                            }
                        }.background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                } else {
                    ZStack {
                        VStack {
                            Image(uiImage: dayImage.info!.image)
                                .resizable()
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.top)
                                .edgesIgnoringSafeArea(.leading)
                                .edgesIgnoringSafeArea(.trailing)
                        }.safeAreaInset(edge: .top) {
                            HStack(alignment: .center, spacing: 0) {
                                Button {
                                    showingPopOver.toggle()
                                } label: {
                                    Image(systemName: "note.text")
                                        .padding(8)
                                        
                                }.sheet(isPresented: $showingSheet) {
                                    APOD_Details_View(dayImage: dayImage)
                                }
                                Divider()
                                    .frame(maxHeight: 30)
                                Button {
                                    shareSheet(image: dayImage.info!.image)
                                } label: {
                                    Image(systemName: "square.and.arrow.up")
                                        .padding(8)
                                        
                                }
                            }.background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                        APOD_PopOver_View(dayImage: dayImage)
                            .padding(50)
                            .background(.ultraThinMaterial)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showingPopOver.toggle()
                                }
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
        .sheet(isPresented: $showingIntroductionView) {
            Introduction_View()
        }
    }
    
    func shareSheet(image: UIImage) {
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)

    }
}

struct APOD_View_v3_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone 8"], id: \.self) { device in
            APOD_View_v3()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
