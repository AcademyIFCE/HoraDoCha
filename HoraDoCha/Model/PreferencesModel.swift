//
//  PreferencesModel.swift
//  HoraDoCha
//
//  Created by Gabriela Bezerra on 12/04/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

struct PreferencesModel {
    
    let soundList: [String] = ["Sino", "Chaleira", "Gota de Água", "Pássaros"]
    
    var selectedSound: String {
        get {
            UserDefaults.standard.value(forKey: UserDefaultsKeys.selectedSound.rawValue) as? String ?? "Chaleira"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.selectedSound.rawValue)
        }
    }
    
    var selectedSoundIndex: Int {
        soundList.firstIndex(of: selectedSound) ?? 1
    }
    
    var selectedCup: String {
        get {
            UserDefaults.standard.value(forKey: UserDefaultsKeys.selectedCup.rawValue) as? String ?? "tea1"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.selectedCup.rawValue)
        }
    }

}
