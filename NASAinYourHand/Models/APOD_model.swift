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

var apiKey: String = "DEMO_KEY"

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
    let date: Date?
    let start_date: Date?
    let end_date: Date?
    let count: Int?
    let thumbs: Bool?
    var api_key: String? = apiKey
}

final class DayImage {
    var resource: String?
    var concept_tags: Bool?
    var title: String?
    var date: String?
    var url: URL?
    var hdurl: URL?
    var media_type: String?
    var explanation: String?
    var concepts: String?
    var thumbnail_url: URL?
    var copyright: String?
    var service_version: String?
    var image: UIImage?
    
    init(resource: String, concept_tags: Bool, title: String, date: String, url: URL, hdurl: URL, media_type: StringLiteralType, explanation: String, concepts: String, thumbnail_url: URL, copyright: String, service_version: String, image: UIImage){
        self.resource = resource
        self.concept_tags = concept_tags
        self.title = title
        self.date = date
        self.url = url
        self.hdurl = hdurl
        self.media_type = media_type
        self.explanation = explanation
        self.concepts = concepts
        self.thumbnail_url = thumbnail_url
        self.copyright = copyright
        self.service_version = service_version
        self.image = image
    }
    
    func getDayImage() {
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")!

        let jsonPublisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: APOD_GET_response.self, decoder: JSONDecoder())
            .compactMap { $0 }
            .share()
            .eraseToAnyPublisher()

        func getImage(url: URL) -> AnyPublisher<UIImage, Error> {
            URLSession.shared
                .dataTaskPublisher(for: url)
                .map(\.data)
                .compactMap { UIImage(data: $0) }
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
        }

        let imagePublisher = jsonPublisher
            .flatMap { item in
                getImage(url: item.url! )
            }

        Publishers.Zip(jsonPublisher, imagePublisher)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Algo ha fallado \(error)")
                }
            } receiveValue: { json, image in
                self.resource = json.resource
                self.concept_tags = json.concept_tags
                self.title = json.title
                self.date = json.date
                self.url = json.url
                self.hdurl = json.hdurl
                self.media_type = json.media_type
                self.explanation = json.explanation
                self.concepts = json.concepts
                self.thumbnail_url = json.thumbnail_url
                self.copyright = json.copyright
                self.service_version = json.service_version
                self.image = image
                
            }
            .store(in: &subscribers)
    }


}
