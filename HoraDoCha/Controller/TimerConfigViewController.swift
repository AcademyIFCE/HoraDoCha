//
//  SettingsViewController.swift
//  HoraDoCha
//
//  Created by Gabriela Bezerra on 07/04/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import UIKit

class TimerConfigViewController: UIViewController {
    
    weak var delegate: SettingsDelegate?
    
    @IBOutlet weak var infusionTimePicker: UIPickerView!
    @IBOutlet weak var teaNameTextField: UITextField!
    
    var selectedMinutesConfig: Int!
    var teaName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infusionTimePicker.delegate = self
        infusionTimePicker.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        infusionTimePicker.selectRow(selectedMinutesConfig - 1, inComponent: 0, animated: animated)
        teaNameTextField.text = teaName
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let name = teaNameTextField.text == "" ? "Chá" : teaNameTextField.text!
        delegate?.didSetTimer(minutes: selectedMinutesConfig, name: name)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension TimerConfigViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let minutesAmount = row + 1
        return minutesAmount > 1 ? "\(minutesAmount) minutos" : "\(minutesAmount) minuto"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMinutesConfig = row + 1
    }
    
}
