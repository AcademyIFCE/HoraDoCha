//
//  PreferencesViewController.swift
//  HoraDoCha
//
//  Created by Gabriela Bezerra on 12/04/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import UIKit

class PreferencesViewController: UIViewController {
    
    @IBOutlet weak var cup1Button: UIButton!
    @IBOutlet weak var cup2Button: UIButton!
    @IBOutlet weak var cup3Button: UIButton!
    @IBOutlet weak var cup4Button: UIButton!
    @IBOutlet weak var soundPicker: UIPickerView!
    
    private var preferences: PreferencesModel = PreferencesModel() {
        didSet {
            showPreferencesDataOnView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soundPicker.delegate = self
        soundPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPreferencesDataOnView()
    }
    
    @IBAction func selectCupAction(_ sender: UIButton) {
        switch sender {
        case cup1Button:
            self.preferences.selectedCup = "tea1"
        case cup2Button:
            self.preferences.selectedCup = "tea2"
        case cup3Button:
            self.preferences.selectedCup = "tea3"
        case cup4Button:
            self.preferences.selectedCup = "tea4"
        default:
            self.preferences.selectedCup = "tea1"
        }
    }
    
    func showPreferencesDataOnView() {
        
        switch preferences.selectedCup {
        case "tea1":
            cup1Button.alpha = 1
            cup2Button.alpha = 0.3
            cup3Button.alpha = 0.3
            cup4Button.alpha = 0.3
        case "tea2":
            cup1Button.alpha = 0.3
            cup2Button.alpha = 1
            cup3Button.alpha = 0.3
            cup4Button.alpha = 0.3
        case "tea3":
            cup1Button.alpha = 0.3
            cup2Button.alpha = 0.3
            cup3Button.alpha = 1
            cup4Button.alpha = 0.3
        case "tea4":
            cup1Button.alpha = 0.3
            cup2Button.alpha = 0.3
            cup3Button.alpha = 0.3
            cup4Button.alpha = 1
        default:
            cup1Button.alpha = 1
            cup2Button.alpha = 0.3
            cup3Button.alpha = 0.3
            cup4Button.alpha = 0.3
        }
        
        soundPicker.selectRow(preferences.selectedSoundIndex, inComponent: 0, animated: true)
    }
}


extension PreferencesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return preferences.soundList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return preferences.soundList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.preferences.selectedSound = preferences.soundList[row]
    }
    
}
