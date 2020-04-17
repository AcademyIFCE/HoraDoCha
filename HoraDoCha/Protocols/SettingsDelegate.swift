//
//  SettingsDelegate.swift
//  HoraDoCha
//
//  Created by Gabriela Bezerra on 07/04/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

protocol SettingsDelegate: class {
    func didSetTimer(minutes: Int, name: String)
}
