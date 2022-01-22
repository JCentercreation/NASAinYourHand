//
//  Asteroids-NeoWs_model_v2.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 22/1/22.
//

import Foundation
import Combine
import UIKit

final class Asteroides: ObservableObject {

    var subscribersAsteroid = Set<AnyCancellable>()

    struct InfoAsteroid: Hashable {
        var name: String
        var closeApproachDate: String
        var velocity: String
        var isDanger: Bool
        var distance: String
    }

    @Published var infoAsteroid: [InfoAsteroid]?

    init(infoAsteroid: [InfoAsteroid]) {
        self.infoAsteroid = infoAsteroid
    }

    func getAsteorids(date: Date, completion: @escaping ([InfoAsteroid]) -> ()){
        print("Funcion Asteroids lanzada")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var dateString = formatter.string(from: date)
        let apiKey = "vfC1VzlR2WfH9S8si12Gcb5WmbVA1lVGyZ757HlU"
        var url = URL(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date="+dateString+"&end_date="+dateString+"&api_key="+apiKey)!
        print(url)

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
            var near_earth_objects: [Asteroid]?

            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.links = try container.decode(Links.self, forKey: .links)
                self.element_count = try container.decode(Int.self, forKey: .element_count)
                let nearEarthOnjectsDic = try container.decode([String: [Asteroid]].self, forKey: .near_earth_objects)
                nearEarthOnjectsDic.first.map { primero in
                    self.near_earth_objects = primero.value
                }
            }
        }

        struct Asteroids_GET_request: Codable{
            let api_key: String
            let date: String
        }

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

            if let asteroides = asteroids.near_earth_objects {
                for asteroid in asteroides {
                    var infoAsteroide = InfoAsteroid(name: "", closeApproachDate: "", velocity: "", isDanger: false, distance: "")
                    infoAsteroide.name = asteroid.name ?? ""
                    infoAsteroide.closeApproachDate = asteroid.close_approach_data?.first?.close_approach_date ?? ""
                    infoAsteroide.velocity = asteroid.close_approach_data?.first?.relative_velocity?.kilometers_per_hour ?? ""
                    infoAsteroide.isDanger = asteroid.is_potentially_hazardous_asteroid ?? false
                    infoAsteroide.distance = asteroid.close_approach_data?.first?.miss_distance?.kilometers ?? ""
                    self.infoAsteroid?.append(infoAsteroide)
                }
                completion(self.infoAsteroid ?? [InfoAsteroid(name: "", closeApproachDate: "", velocity: "", isDanger: false, distance: ""), InfoAsteroid(name: "", closeApproachDate: "", velocity: "", isDanger: false, distance: "")])
            }
        }
        .store(in: &subscribers)
    }

}

