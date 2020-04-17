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
    
}

extension TeaTimerModel: TimerDelegate {
    
    func startTimerWithController(controller: UIViewController) {
        
        //Pegar referêcia da controller
        let controllerR = controller as? TimerViewController
        
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
                
                DispatchQueue.main.async { //Na Thread main... (Precisa ser na main porque vai modificar diretamente algo na tela)
                    
                    //Cria alert (janelinha modal padrao do iOS)
                    let alert = UIAlertController(title: "Hora do Chá!", message: nil, preferredStyle: .alert)
                    
                    //Cria botão da janelinha, passando uma ação pra executar quando ele for clicado no handler dele
                    let button = UIAlertAction(title: "Resetar Timer", style: .default, handler: { alert in
                        controllerR?.settingsButton(controllerR!)
                    })
                    
                    //Adiciona botao no alert
                    alert.addAction(button)
                    
                    //A tela (self) exibe o alert para o usuário
                    controllerR?.present(alert, animated: true, completion: nil)
                    
                }
                
            }
             //Seta a informação na label da controller
             controllerR?.showTimerDataOnView()
        }
        
        
        
        //Começa a rodar o timer
        timer?.fire()
    }
    
    
}
