//
//  SignPremiumViewController.swift
//  HoraDoCha
//
//  Created by Gabriela Bezerra on 13/04/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import UIKit

class SignPremiumViewController: UIViewController {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.presentingViewController as? UITabBarController)?.selectedIndex = 1
    }
    
    @IBAction func fecharAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
