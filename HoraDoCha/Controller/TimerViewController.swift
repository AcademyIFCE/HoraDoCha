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
    
    var timerDelegate: TimerDelegate?
    
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
        timerDelegate = self.teaTimer
        timerDelegate!.startTimerWithController(controller: self)
       
        
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

