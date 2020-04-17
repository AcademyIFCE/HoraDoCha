//
//  Tea.swift
//  HoraDoCha
//
//  Created by Gabriela Bezerra on 07/04/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

struct TeaTimerModel {
    
    weak var timer: Timer?
    
    private(set) var infusionTimeInterval: TimeInterval {
        get {
            UserDefaults.standard.value(forKey: UserDefaultsKeys.infusionTime.rawValue) as? TimeInterval ?? 180
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.infusionTime.rawValue)
        }
    }
    
    var infusionTimeInMinutes: Int {
        Int(infusionTimeInterval / 60)
    }
    
    var timerDescription: String {
        formatTime(infusionTimeInterval)
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        if let formattedString = formatter.string(from: time) {
            return formattedString
        } else {
            return "--:--"
        }
    }
    
    var teaName: String {
        get {
            UserDefaults.standard.value(forKey: UserDefaultsKeys.teaName.rawValue) as? String ?? "Chá"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.teaName.rawValue)
        }
    }
    
    var imageName: String {
        UserDefaults.standard.value(forKey: UserDefaultsKeys.selectedCup.rawValue) as? String ?? "tea1"
    }
    
    mutating func setTimer(minutes: Int) {
        self.infusionTimeInterval = TimeInterval(minutes * 60)
        timer?.invalidate()
    }
    
    mutating func setTimer(interval: TimeInterval) {
        self.infusionTimeInterval = interval
    }
    
}
