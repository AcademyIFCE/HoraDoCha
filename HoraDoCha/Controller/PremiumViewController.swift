//
//  PremiumViewController.swift
//  HoraDoCha
//
//  Created by Gabriela Bezerra on 13/04/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import UIKit

class PremiumViewController: UIViewController {
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) {
            self.performSegue(withIdentifier: "premiumSegue", sender: self)
        }
    }
    
}
