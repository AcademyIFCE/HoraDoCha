//
//  TimerViewController.swift
//  HoraDoCha
//
//  Created by Gabriela Bezerra on 07/04/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var teaNameLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    private var teaTimer: TeaTimerModel = TeaTimerModel() {
        didSet {
            showTimerDataOnView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTimerDataOnView()
    }
    
    func showTimerDataOnView() {
        
        self.teaNameLabel.text = teaTimer.teaName
        
        self.timerLabel.text = teaTimer.timerDescription
        
        if let teaCupImage = UIImage(named: teaTimer.imageName) {
            self.imageView.image = teaCupImage
        }
    }
    
    @IBAction func timerButton(_ sender: Any) {
        
        self.timerButton.isHidden = true
        
        // Cria o Timer
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            //Closure que configura o código que vai rodar a cada intervalo de tempo
            
            print("tick \(self.teaTimer.timerDescription)")
            
            //Decrementa os segundos do teaTimer
            self.teaTimer.setTimer(interval: self.teaTimer.infusionTimeInterval - 1)
            
            //Quando o tempo do teaTimer for menor que zero
            if self.teaTimer.infusionTimeInterval < 0 {
                
                //Para o timer
                timer.invalidate()
                
                //Reseta o teaTimer para o tempo padrao 3
                self.teaTimer.setTimer(minutes: 3)
                
                DispatchQueue.main.async { //Na Thread main... (Precisa ser na main porque vai modificar diretamente algo na tela)
                    
                    //Cria alert (janelinha modal padrao do iOS)
                    let alert = UIAlertController(title: "Hora do Chá!", message: nil, preferredStyle: .alert)
                    
                    //Cria botão da janelinha, passando uma ação pra executar quando ele for clicado no handler dele
                    let button = UIAlertAction(title: "Resetar Timer", style: .default, handler: { alert in
                        self.settingsButton(self)
                    })
                    
                    //Adiciona botao no alert
                    alert.addAction(button)
                    
                    //A tela (self) exibe o alert para o usuário
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
        
        self.teaTimer.timer = timer
        
        //Começa a rodar o timer
        timer.fire()
        
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        self.performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UINavigationController,
            let timerConfigViewController = destination.viewControllers.first as? TimerConfigViewController {
            timerConfigViewController.delegate = self
            timerConfigViewController.selectedMinutesConfig = teaTimer.infusionTimeInMinutes
            timerConfigViewController.teaName = teaTimer.teaName
        }
    }
}



extension TimerViewController: SettingsDelegate {
    
    func didSetTimer(minutes: Int, name: String) {
        self.teaTimer.setTimer(minutes: minutes)
        self.teaTimer.teaName = name
        self.timerButton.isHidden = false
    }
    
}

