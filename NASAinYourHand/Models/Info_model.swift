//
//  Info_model.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 12/4/22.
//

import Foundation

class InfoDefaults: ObservableObject {
    
    private var defaults = UserDefaults.standard
    
    @Published var alreadyLaunched: Bool
    
    init(alreadyLaunched: Bool) {
        self.alreadyLaunched = alreadyLaunched
        self.alreadyLaunched = getValue(type: .boolean, key: "alreadyLaunched") as? Bool ?? false
    }
    
    private func setValue(value: Any, key: String) {
        defaults.set(value, forKey: key)
    }
    
    enum Types {
        case integer
        case double
        case boolean
        case string
    }
    
    private func getValue(type: Types, key: String) -> Any {
        switch(type) {
            case .integer:
                return defaults.integer(forKey: key)
            case .double:
                return defaults.double(forKey: key)
            case .boolean:
                return defaults.bool(forKey: key)
            case .string:
                return defaults.string(forKey: key) as Any
        }
    }
    
    func showIntroductionView() -> Bool {
        if self.alreadyLaunched == false {
            setValue(value: true, key: "alreadyLaunched")
            return true
        } else {
            return false
        }
    }
    
    func resetFirstLaunch() {
        setValue(value: false, key: "alreadyLaunched")
        self.alreadyLaunched = false
    }
    
}
