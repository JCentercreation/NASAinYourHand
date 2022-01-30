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
        asteroids.getAsteorids(date: date) { asteroides in
            for asteroide in asteroides {
                asteroids.infoAsteroid?.append(asteroide)
                print((asteroide))
            }
        }
    }
    
    var body: some View {
        VStack{
            VStack{
                DatePicker("Date", selection: $date,in: dateRange, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .onChange(of: date) { newValue in
                        asteroidsInfo(date: newValue)
                    }
            }
            Spacer()
            VStack{
                if asteroids.infoAsteroid?.isEmpty == false {
                    HStack{
                        Spacer()
                        Toggle(isOn: $showOnlyHazardous) {
                            Text("Show only hazardous asteroids")
                        }.edgesIgnoringSafeArea(.bottom)
                        Spacer()
                    }
                    List {
                        if showOnlyHazardous == false {
                            ForEach(asteroids.infoAsteroid ?? [], id: \.self) { asteroide in
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("Name: \(asteroide.name)")
                                        Text("Close approach date: \(asteroide.closeApproachDate)")
                                        Text("Velocity: \(asteroide.velocity) Km/h")
                                        Text("Closest distance: \(asteroide.distance) Km")
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
                                        Text("Name: \(asteroide.name)")
                                        Text("Close approach date: \(asteroide.closeApproachDate)")
                                        Text("Velocity: \(asteroide.velocity) Km/h")
                                        Text("Closest distance: \(asteroide.distance) Km")
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
