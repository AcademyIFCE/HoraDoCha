//
//  PreferencesModelTests.swift
//  HoraDoChaTests
//
//  Created by Ronaldo Gomes on 12/07/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import XCTest
@testable import HoraDoCha

class PreferencesModelTests: XCTestCase {
    
    func test_selectSound_setSino_notChaleira(){
        
        //Given
        var sut = PreferencesModel()
        
        //When
        sut.selectedSound = "Sino"
        
        //Then
        XCTAssertNotEqual(sut.selectedSound, "Chaleira")
    }
    
    func test_selectedCup_setTea2_notTea1(){
        
        //Given
        var sut = PreferencesModel()
        
        //When
        sut.selectedCup = "tea2"
        
        //Then
        XCTAssertNotEqual(sut.selectedCup, "tea1")
    }
    
    func test_selectedSoundIndex_indexOfGotadeAgua_indexTwo(){
        
        //Given
        var sut = PreferencesModel()
        sut.selectedSound = "Gota de Água"
        
        //When
        let indexOfSound = sut.selectedSoundIndex
        
        //Then
        XCTAssertEqual(indexOfSound, 2)
    }
}
