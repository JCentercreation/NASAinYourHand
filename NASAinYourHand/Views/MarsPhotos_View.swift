//
//  MarsPhotos_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 13/3/22.
//

import SwiftUI

struct MarsPhotos_View: View {
    @StateObject var marsPhotos = MarsPhotos(infoMarsPhotos: [])
    @State var date: Date = Date.now
    
    @State var showDatePicker: Bool = false
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2015, month: 1, day: 1)
        let nowDate = Date.now
        let nowCalendar = Calendar.current
        let nowYear = nowCalendar.component(.year, from: nowDate)
        let nowMonth = nowCalendar.component(.month, from: nowDate)
        let nowDay = nowCalendar.component(.day, from: nowDate)
        let endComponents = DateComponents(year: nowYear, month: nowMonth, day: nowDay)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    func marsPhotosInfo(date: Date){
        marsPhotos.infoMarsPhotos?.removeAll()
        marsPhotos.getMarsPhotos(date: date, rover: .curiosity) { photosArray in
            for marsPhoto in photosArray {
                marsPhotos.infoMarsPhotos?.append(marsPhoto)
            }
        }
    }
    
    var body: some View {
        VStack{
            HStack {
                Text(NSLocalizedString("MarsPhotosView.title", comment: ""))
                    .fontWeight(.bold)
                    .font(Font.title)
                    .foregroundColor(Color(red: 231 / 255, green: 69 / 255, blue: 53 / 255))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                Spacer()
            }
            HStack {
                Button {
                    withAnimation {
                        showDatePicker.toggle()
                    }
                } label: {
                    HStack {
                        Text(NSLocalizedString("MarsPhotosView.dateField.title", comment: ""))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(date.formatted(date: .numeric, time: .omitted))")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 231 / 255, green: 69 / 255, blue: 53 / 255))
                    }
                }
            }.buttonStyle(.bordered)
            .tint(Color(red: 181 / 255, green: 205 / 255, blue: 243 / 255))
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            if showDatePicker == true {
                DatePicker(NSLocalizedString("MarsPhotosView.datePicker.title", comment: ""), selection: $date,in: dateRange, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale.init(identifier: "en_GB"))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .onChange(of: date) { newValue in
                        marsPhotosInfo(date: newValue)
                    }
            }
            Spacer()
            VStack{
                if marsPhotos.infoMarsPhotos?.isEmpty == false {
                    ScrollView {
                        let columns = [
                                GridItem(.adaptive(minimum: 80))
                            ]
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(marsPhotos.infoMarsPhotos ?? [], id: \.self) { foto in
                                AsyncImage(url: URL(string: foto.image_url), content: { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 100, maxHeight: 100)
                                        .cornerRadius(15)
                                        .shadow(color: .darkShadow, radius: 5, x: 0, y: 0)
                                }, placeholder: {
                                    ProgressView()
                                })
                            }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                } else {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(Color.blue)
                        .scaleEffect(2, anchor: .center)
                    Spacer()
                }
            }
        }.onAppear {
            marsPhotosInfo(date: Date.now)
        }
    }
}

struct MarsPhotos_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"],id: \.self) { device in
            MarsPhotos_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
