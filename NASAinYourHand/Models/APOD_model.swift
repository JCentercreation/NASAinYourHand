//
//  APOD_model.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 11/1/22.
//

import Foundation
import Combine
import UIKit

var subscribers = Set<AnyCancellable>()

var apiKey: String = "vfC1VzlR2WfH9S8si12Gcb5WmbVA1lVGyZ757HlU"

struct APOD_GET_response: Codable {
    let resource: String?
    let concept_tags: Bool?
    let title: String?
    let date: String?
    let url: URL?
    let hdurl: URL?
    let media_type: String?
    let explanation: String?
    let concepts: String?
    let thumbnail_url: URL?
    let copyright: String?
    let service_version: String?
}

struct APOD_GET_request: Codable {
    let date: Date
    let start_date: Date
    let end_date: Date
    let count: Int
    let thumbs: Bool
    var api_key: String = apiKey
}

struct Info {
    var resource: String
    var concept_tags: Bool
    var title: String
    var date: String
    var media_type: String
    var explanation: String
    var concepts: String
    var copyright: String
    var service_version: String
    var image: UIImage
}

final class DayImage: ObservableObject {
    
    @Published var info: Info?
    
    init(info: Info) {
        self.info = info
    }
    
    func getDayImage(completion: @escaping (Info) -> ()) {
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key="+apiKey)!

        let jsonPublisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APOD_GET_response.self, decoder: JSONDecoder())
            .compactMap { $0 }
            .share()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()

        func getImage(url: URL) -> AnyPublisher<UIImage, Error> {
            URLSession.shared
                .dataTaskPublisher(for: url)
                .map(\.data)
                .compactMap { UIImage(data: $0) }
                .mapError { $0 as Error }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }

        let imagePublisher = jsonPublisher
            .flatMap { item in
                getImage(url: item.url ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg")!)
            }

        Publishers.Zip(jsonPublisher, imagePublisher)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Algo ha fallado \(error)")
                }
            } receiveValue: { json, image in
                self.info?.resource = json.resource ?? ""
                self.info?.concept_tags = json.concept_tags ?? false
                self.info?.title = json.title ?? ""
                self.info?.date = json.date ?? ""
                self.info?.media_type = json.media_type ?? ""
                self.info?.explanation = json.explanation ?? ""
                self.info?.concepts = json.concepts ?? ""
                self.info?.copyright = json.copyright ?? ""
                self.info?.service_version = json.service_version ?? ""
                self.info?.image = image
                
                completion(self.info ?? Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "map")!))
            }
            .store(in: &subscribers)
    }
    
    func getImage(date: Date, completion: @escaping (Info) -> ()) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var dateString = formatter.string(from: date)
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?" + "date=" + dateString + "&api_key=" + apiKey)!

        let jsonPublisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APOD_GET_response.self, decoder: JSONDecoder())
            .compactMap { $0 }
            .share()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()

        func getImage(url: URL) -> AnyPublisher<UIImage, Error> {
            URLSession.shared
                .dataTaskPublisher(for: url)
                .map(\.data)
                .compactMap { UIImage(data: $0) }
                .mapError { $0 as Error }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }

        let imagePublisher = jsonPublisher
            .flatMap { item in
                getImage(url: item.url ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg")!)
            }

        Publishers.Zip(jsonPublisher, imagePublisher)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Algo ha fallado \(error)")
                }
            } receiveValue: { json, image in
                self.info?.resource = json.resource ?? ""
                self.info?.concept_tags = json.concept_tags ?? false
                self.info?.title = json.title ?? ""
                self.info?.date = json.date ?? ""
                self.info?.media_type = json.media_type ?? ""
                self.info?.explanation = json.explanation ?? ""
                self.info?.concepts = json.concepts ?? ""
                self.info?.copyright = json.copyright ?? ""
                self.info?.service_version = json.service_version ?? ""
                self.info?.image = image
                
                completion(self.info ?? Info(resource: "", concept_tags: false, title: "", date: "", media_type: "", explanation: "", concepts: "", copyright: "", service_version: "", image: UIImage(systemName: "map")!))
            }
            .store(in: &subscribers)
    }


}
