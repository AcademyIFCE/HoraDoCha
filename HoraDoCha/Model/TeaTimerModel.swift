//
//  Tea.swift
//  HoraDoCha
//
//  Created by Gabriela Bezerra on 07/04/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import UIKit

class TeaTimerModel {
    
    weak var timer: Timer?
    weak var delegate: TimerDelegate?
    
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
    
    func setTimer(minutes: Int) {
        self.infusionTimeInterval = TimeInterval(minutes * 60)
        timer?.invalidate()
    }
    
    func setTimer(interval: TimeInterval) {
        self.infusionTimeInterval = interval
    }
    
    func createTimer() {
        
        // Cria o Timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            //Closure que configura o código que vai rodar a cada intervalo de tempo
            
            print("tick \(self.timerDescription)")
            
            //Decrementa os segundos do teaTimer
            self.setTimer(interval: self.infusionTimeInterval - 1)
            
            //Quando o tempo do teaTimer for menor que zero
            if self.infusionTimeInterval < 0 {
                
                //Para o timer
                timer.invalidate()
                
                //Reseta o teaTimer para o tempo padrao 3
                self.setTimer(minutes: 3)
                
                self.delegate?.createTimerAlert(title: "Hora do Chá!")
                
            }
            //Seta a informação na label da controller
            self.delegate?.updateTimerLabel(description: self.timerDescription)
        }
        
        //Começa a rodar o timer
        timer?.fire()
    }
    
}
