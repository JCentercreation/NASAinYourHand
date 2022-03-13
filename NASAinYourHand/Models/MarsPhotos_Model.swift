//
//  MarsPhotos_Model.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 13/3/22.
//

import Foundation
import Combine
import UIKit

struct InfoMarsPhotos: Hashable {
    var id: Int
    var camera_name: String
    var image: UIImage
}

final class MarsPhotos: ObservableObject {
    
    var subscribersMarsPhotos = Set<AnyCancellable>()
    
    @Published var infoMarsPhotos: [InfoMarsPhotos]? = []
    
    init(infoMarsPhotos: [InfoMarsPhotos]){
        self.infoMarsPhotos = infoMarsPhotos
    }
    
    func getMarsPhotos(date: Date, rover: RoverType){
        let formatter = DateFormatter()
        var dateString = formatter.string(from: date)
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
        var url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/"+roverString+"/photos?earth_date="+dateString+"&api_key="+apiKey)
    }
    
    
}

enum RoverType: Codable {
    case curiosity
    case oportunity
    case spirit
}

struct MarsPhotos_GET_request: Codable {
    let date: Date
    let rover: RoverType
    var apiKey: String
}

struct MarsPhotos_GET_response: Codable {
    
}
