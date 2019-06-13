//
//  InsightRecorderInteractorTests.swift
//  InsightTests
//
//  Created by Douglas Mandarino on 11/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import XCTest
@testable import Insight

class InsightRecorderInteractorTests: XCTestCase {
    
    private var sut: InsightRecorderInteractor?
    private var expectation: XCTestExpectation?
    
    override func setUp() {
        self.sut = InsightRecorderInteractorBuilder.build()
    }
    
    override func tearDown() {
        self.sut = nil
        self.expectation = nil
    }
    
    func testStartRecording() {
        self.expectation = XCTestExpectation(description: "test start recording")
        let mock = InsightPresenterMock(expectation: self.expectation!)
        self.sut?.setupInteractor(with: mock)
        self.sut?.startOrStopRecording()
        
        wait(for: [expectation!], timeout: 2)
    }
    
    func testStopRecording() {
        self.expectation = XCTestExpectation(description: "test stop recording")
        let mock = InsightPresenterMock(expectation: self.expectation!)
        self.sut?.setupInteractor(with: mock)
        self.sut?.startOrStopRecording()
        
        wait(for: [expectation!], timeout: 2)
    }
    
    func testStartBroadcast() {
        self.expectation = XCTestExpectation(description: "test start broadcast")
        let mock = InsightPresenterMock(expectation: self.expectation!)
        self.sut?.setupInteractor(with: mock)
        self.sut?.startOrStopBroadcast()
        
        wait(for: [expectation!], timeout: 2)
    }
    
    func testStopBroadcast() {
        self.expectation = XCTestExpectation(description: "test stop broadcast")
        let mock = InsightPresenterMock(expectation: self.expectation!)
        self.sut?.setupInteractor(with: mock)
        self.sut?.startOrStopBroadcast()
        
        wait(for: [expectation!], timeout: 2)
    }
}

private class InsightPresenterMock: InsightRecorderInteractorDelegate {
    
    var expectation: XCTestExpectation?
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func startRecording() {
        self.expectation?.fulfill()
    }
    
    func stopRecording() {
        self.expectation?.fulfill()
    }
    
    func startBroadcast() {
        self.expectation?.fulfill()
    }
    
    func broadcastEnded() {
        self.expectation?.fulfill()
    }
}
