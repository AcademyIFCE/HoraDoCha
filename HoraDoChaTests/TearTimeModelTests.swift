//
//  TearTimeModelTests.swift
//  HoraDoChaTests
//
//  Created by Ronaldo Gomes on 12/07/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import XCTest
@testable import HoraDoCha

class TearTimeModelTests: XCTestCase {

    func test_formatTime_sixtySeconds_oneMinute(){
        
        //Given
        let sut = TeaTimerModel()
        
        //When
        let formatTime = sut.formatTime(60)
        let timeExpected = "01:00"
        
        //Then
        XCTAssertEqual(formatTime, timeExpected)
    }
    
    func test_setTimer_oneMinuteInterval_notOneHundredAndEightySeconds(){
        
        //Given
        let sut = TeaTimerModel()
        
        //When
        sut.setTimer(interval: 60)
        let formatTime = sut.infusionTimeInterval
        let timeNotExpected = TimeInterval(180)
        
        //Then
        XCTAssertNotEqual(formatTime, timeNotExpected)
    }
    
    func test_createTimer_teaTimerLessThenZero_TimeThreeMinutes(){
        
        //Given
        let sut = TeaTimerModel()
        
        //When
        sut.setTimer(interval: -1)
        sut.createTimer()
        let timerStandard = TimeInterval(180)
        
        //Then
        XCTAssertEqual(sut.infusionTimeInterval, timerStandard)
        
    }
    
    func test_teaName_nameBoldo_nameNotCha(){
        
        //Given
        let sut = TeaTimerModel()
        
        //When
        sut.teaName = "Boldo"
        
        //Then
        XCTAssertNotEqual(sut.teaName, "Cha")
    }
}
