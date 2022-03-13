//
//  MarsPhotos_Model.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 13/3/22.
//

import Foundation
import Combine
import UIKit

struct InfoMarsPhoto: Hashable {
    var id: Int
    var camera_name: String
    var image_url: String
}

enum RoverType: Codable {
    case curiosity
    case oportunity
    case spirit
}

final class MarsPhotos: ObservableObject {
    
    var subscribersMarsPhotos = Set<AnyCancellable>()
    
    @Published var infoMarsPhotos: [InfoMarsPhoto]? = []
    
    init(infoMarsPhotos: [InfoMarsPhoto]){
        self.infoMarsPhotos = infoMarsPhotos
    }
    
    func getMarsPhotos(date: Date, rover: RoverType, completion: @escaping ([InfoMarsPhoto]) -> ()){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        var roverString: String {
            switch rover {
            case .curiosity:
                return "curiosity"
            case .oportunity:
                return "oportunity"
            case .spirit:
                return "spirit"
            }
        }
        let apiKey = "vfC1VzlR2WfH9S8si12Gcb5WmbVA1lVGyZ757HlU"
        let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/"+roverString+"/photos?earth_date="+dateString+"&api_key="+apiKey)
        print(url)
        
        struct Camera: Codable {
            let id: Int?
            let name: String?
            let rover_id: Int?
            let full_name: String?
        }
        
        struct Rover: Codable {
            let id: Int?
            let name: String?
            let landing_date: String?
            let launch_date: String?
            let status: String?
        }
        
        struct MarsPhoto: Codable {
            let id: Int?
            let sol: Int?
            let camera: Camera?
            let img_src: String?
            let earth_date: String?
            let rover: Rover?
        }
        
        struct MarsPhotos_GET_response: Codable {
            let photos: [MarsPhoto]?
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let photosDic = try container.decode([MarsPhoto].self, forKey: .photos)
                self.photos = photosDic
            }
        }
        
        struct MarsPhotos_GET_request: Codable {
            let date: Date
            let rover: RoverType
            var apiKey: String
        }
        
        if let url = url {
            let marsPhotosPublisher = URLSession.shared
                .dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: MarsPhotos_GET_response.self, decoder: JSONDecoder())
                .compactMap { $0 }
                .share()
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
            
            marsPhotosPublisher.sink { completion in
                if case .failure(let error) = completion {
                    print("Algo ha fallado \(error)")
                }
            } receiveValue: { data in
                data.photos.flatMap { fotos in
                    fotos.flatMap { foto in
                        var infoFoto = InfoMarsPhoto(id: foto.id ?? 0, camera_name: foto.camera?.name ?? "", image_url: foto.img_src ?? "")
                        self.infoMarsPhotos?.append(infoFoto)
                    }
                    completion(self.infoMarsPhotos ?? [InfoMarsPhoto(id: 0, camera_name: "", image_url: "")])
                }
            }.store(in: &subscribersMarsPhotos)

            
        }
        
    }
    
    
    
    
}






