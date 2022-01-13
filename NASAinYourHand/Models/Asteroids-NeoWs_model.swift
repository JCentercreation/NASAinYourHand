//
//  Asteroids-NeoWs_model.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 13/1/22.
//

import Foundation
import Combine
import UIKit

struct Links: Codable{
    let next: URL?
    let prev: URL?
    let current: URL?
    
    enum CodingKeys: String, CodingKey {
        case next = "next"
        case prev = "prev"
        case current = "self"
    }
}

struct NearEarthObjects: Codable{
    let date: [Asteroid]?
    
    enum CodingKeys: String, CodingKey {
        case date = "2015-09-07"
    }
}

struct Asteroid: Codable{
    let links: Links?
    let id: String?
    let neo_reference_id: String?
    let name: String?
    let nasa_jpl_url: URL?
    let absolute_magnitude_h: Double?
    let estimated_diameter: EstimatedDiameter?
    let is_potentially_hazardous_asteroid: Bool?
    let close_approach_data: [CloseApproachData]?
    let is_sentry_object: Bool?
}

struct EstimatedDiameter: Codable{
    let kilometers: EstimatedDiameterMaxMin?
    let meters: EstimatedDiameterMaxMin?
    let miles: EstimatedDiameterMaxMin?
    let feet: EstimatedDiameterMaxMin?
}

struct EstimatedDiameterMaxMin: Codable{
    let estimated_diameter_min: Double?
    let estimated_diameter_max: Double?
}

struct CloseApproachData: Codable{
    let close_approach_date: String?
    let close_approach_date_full: String?
    let epoch_date_close_approach: Int?
    let relative_velocity: RelativeVelocity?
    let miss_distance: MissDistance?
    let orbiting_body: String?
}

struct RelativeVelocity: Codable{
    let kilometers_per_second: String?
    let kilometers_per_hour: String?
    let miles_per_hour: String?
}

struct MissDistance: Codable{
    let astronomical: String?
    let lunar: String?
    let kilometers: String?
    let miles: String?
}

struct Asteroids_GET_response: Codable {
    let links: Links?
    let element_count: Int?
    let near_earth_objects: NearEarthObjects?
}

struct Asteroids_GET_request: Codable{
    let api_key: String
    let date: String
}

var subscribersAsteroid = Set<AnyCancellable>()

struct InfoAsteroid {
    var name: String
    var closeApproachDate: String
    var velocity: String
    var isDanger: Bool
}

final class Asteroides: ObservableObject {
    
    @Published var infoAsteroid: [InfoAsteroid]?
    
    init(infoAsteroid: [InfoAsteroid]) {
        self.infoAsteroid = infoAsteroid
    }
    
    func getAsteorids(completion: @escaping ([InfoAsteroid]) -> ()){
        print("Funcion lanzada")
        let url = URL(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date=2015-09-07&end_date=2015-09-07&api_key=DEMO_KEY")!

        let asteroidsPublisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Asteroids_GET_response.self, decoder: JSONDecoder())
            .compactMap { $0 }
            .share()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        asteroidsPublisher.sink { completion in
            if case .failure(let error) = completion {
                print("Algo ha fallado \(error)")
            }
        } receiveValue: { asteroids in
            print("Recibida la respuesta")
            print("\(asteroids)")
            
            if let asteroides = asteroids.near_earth_objects?.date {
                for asteroid in asteroides {
                    var infoAsteroide = InfoAsteroid(name: "", closeApproachDate: "", velocity: "", isDanger: false)
                    infoAsteroide.name = asteroid.name ?? ""
                    infoAsteroide.closeApproachDate = asteroid.close_approach_data?.first?.close_approach_date ?? ""
                    infoAsteroide.velocity = asteroid.close_approach_data?.first?.relative_velocity?.kilometers_per_hour ?? ""
                    infoAsteroide.isDanger = asteroid.is_potentially_hazardous_asteroid ?? false
                    self.infoAsteroid?.append(infoAsteroide)
                }
                completion(self.infoAsteroid ?? [InfoAsteroid(name: "", closeApproachDate: "", velocity: "", isDanger: false), InfoAsteroid(name: "", closeApproachDate: "", velocity: "", isDanger: false)])
            }
        }
        .store(in: &subscribers)
    }
    
}
