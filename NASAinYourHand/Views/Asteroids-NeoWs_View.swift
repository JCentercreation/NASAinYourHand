//
//  Asteroids-NeoWs_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 14/1/22.
//

import SwiftUI

struct Asteroids_NeoWs_View: View {
    
    @StateObject var asteroids = Asteroides(infoAsteroid: [])
    @State var date: Date = Date.now
    
    @State var showDatePicker: Bool = false
    
    @State private var showOnlyHazardous: Bool = false
    private var hazardousAsteroids: [InfoAsteroid] {
        asteroids.infoAsteroid?.filter({ asteroid in
            (!showOnlyHazardous || asteroid.isDanger)
        }) ?? [InfoAsteroid(name: "", closeApproachDate: "", velocity: "", isDanger: false, distance: "")]
    }
    
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
    
    func asteroidsInfo(date: Date){
        asteroids.infoAsteroid?.removeAll()
        print(asteroids.infoAsteroid!)
        asteroids.getAsteorids(date: date) { asteroides in
            for asteroide in asteroides {
                print((asteroide))
            }
        }
    }
    
    var body: some View {
        VStack{
            HStack {
                Text(NSLocalizedString("AsteroidsNeoWsView.title", comment: ""))
                    .fontWeight(.bold)
                    .font(Font.title)
                    .foregroundColor(.purple)
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
                        Text(NSLocalizedString("AsteroidsNeoWsView.dateField.title", comment: ""))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(date.formatted(date: .numeric, time: .omitted))")
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                    }
                }
            }.buttonStyle(.bordered)
            .tint(Color(red: 181 / 255, green: 205 / 255, blue: 243 / 255))
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            if showDatePicker == true {
                DatePicker(NSLocalizedString("AsteroidsNeoWsView.datePicker.title", comment: ""), selection: $date,in: dateRange, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale.init(identifier: "en_GB"))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .onChange(of: date) { newValue in
                        asteroidsInfo(date: newValue)
                    }
            }
            Spacer()
            VStack{
                Toggle(isOn: $showOnlyHazardous) {
                    Text(NSLocalizedString("AsteroidsNeoWsView.filterToggle.title", comment: ""))
                        .fontWeight(.bold)
                }.padding(.horizontal, 30)
                    .tint(.purple)
                if asteroids.infoAsteroid?.isEmpty == false {
                    List {
                        if showOnlyHazardous == false {
                            ForEach(asteroids.infoAsteroid ?? [], id: \.self) { asteroide in
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(NSLocalizedString("AsteroidsNeoWsView.cell.name", comment: "") + asteroide.name)
                                        Text(NSLocalizedString("AsteroidsNeoWsView.cell.velocity", comment: "") + "\(round(Double(asteroide.velocity)!))" + NSLocalizedString("AsteroidsNeoWsView.cell.velocity.km", comment: ""))
                                        Text(NSLocalizedString("AsteroidsNeoWsView.cell.distance", comment: "") + "\(round(Double(asteroide.distance)!))" + NSLocalizedString("AsteroidsNeoWsView.cell.distance.km", comment: ""))
                                    }
                                    Spacer()
                                    if asteroide.isDanger == true {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        } else {
                            ForEach(hazardousAsteroids, id: \.self) { asteroide in
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(NSLocalizedString("AsteroidsNeoWsView.cell.name", comment: "") + asteroide.name)
                                        Text(NSLocalizedString("AsteroidsNeoWsView.cell.velocity", comment: "") +  "\(round(Double(asteroide.velocity)!))"  + NSLocalizedString("AsteroidsNeoWsView.cell.velocity.km", comment: ""))
                                        Text(NSLocalizedString("AsteroidsNeoWsView.cell.distance", comment: "") + "\(round(Double(asteroide.distance)!))" + NSLocalizedString("AsteroidsNeoWsView.cell.distance.km", comment: ""))
                                    }
                                    Spacer()
                                    if asteroide.isDanger == true {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                    }
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
            asteroidsInfo(date: Date.now)
        }
    }
}

struct Asteroids_NeoWs_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max"], id: \.self) { device in
            Asteroids_NeoWs_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
