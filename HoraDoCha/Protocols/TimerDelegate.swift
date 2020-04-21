//
//  TimerDelegate.swift
//  HoraDoCha
//
//  Created by VInicius Mesquita on 17/04/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import UIKit

protocol TimerDelegate: class {
    func updateTimerLabel(description: String)
    func createTimerAlert(title: String)
}
