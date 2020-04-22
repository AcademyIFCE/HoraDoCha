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
        
        //Seta o timer delegate
        teaTimer.delegate = self
        
        self.timerButton.isHidden = true
        
        //Chama a função que cria e atualiza o timer
        teaTimer.createTimer()
        
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

extension TimerViewController: TimerDelegate {
    
    func createTimerAlert(title: String) {
        DispatchQueue.main.async { //Na Thread main... (Precisa ser na main porque vai modificar diretamente algo na tela)
            
            //Cria alert (janelinha modal padrao do iOS)
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            
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
    
    func updateTimerLabel(description: String) {
        self.timerLabel.text = description
    }
    
}

