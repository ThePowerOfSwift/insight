//
//  InsightPresenterTests.swift
//  InsightTests
//
//  Created by Douglas Mandarino on 13/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import XCTest
@testable import Insight

class InsightPresenterProtocolTests: XCTestCase {
    
    private var sut: InsightPresenterProtocol?
    private var expectation: XCTestExpectation?
    
    override func tearDown() {
        self.sut = nil
        self.expectation = nil
    }
    
    func testStartRecording() {
        self.expectation = XCTestExpectation(description: "test start recording")
        let mock = InsightPresenterDelegateMock(expectation: self.expectation!)
        self.sut = InsightPresenterBuilder.build(delegate: mock)
        self.sut?.didTapRecordButton(toBroadcast: false)
        
        wait(for: [expectation!], timeout: 2)
    }
    
    func testStopRecording() {}
    
    func testStartBroadcast() {
        self.expectation = XCTestExpectation(description: "test start broadcast")
        let mock = InsightPresenterDelegateMock(expectation: self.expectation!)
        self.sut = InsightPresenterBuilder.build(delegate: mock)
        self.sut?.didTapRecordButton(toBroadcast: true)
        
        wait(for: [expectation!], timeout: 2)
    }
    
    func testStopBroadcast() {}
    
    
    func testDidSelectToImport() {
        self.expectation = XCTestExpectation(description: "test start broadcast")
        let mock = InsightPresenterDelegateMock(expectation: self.expectation!)
        self.sut = InsightPresenterBuilder.build(delegate: mock)
        self.sut?.didSelectToImport(from: url)
        
        wait(for: [expectation!], timeout: 2)
    }
}

class InsightPresenterDocumentInteractorDelegateTests: XCTestCase {
    
    private var sut: InsightDocumentInteractorDelegate?
    private var expectation: XCTestExpectation?
    
    override func tearDown() {
        self.sut = nil
        self.expectation = nil
    }
    
    func testFetchDocument() {
        self.expectation = XCTestExpectation(description: "test did fetch document")
        let mock = InsightPresenterDelegateMock(expectation: self.expectation!)
        self.sut = InsightPresenterBuilder.build(delegate: mock)
        let document = PDFDocumentMapperMock.create()
        self.sut?.didFetchDocument(document: document)
        
        wait(for: [expectation!], timeout: 2)
    }
    
    func testDidFailFetchDocument() {
        self.expectation = XCTestExpectation(description: "test did fail fetch document")
        let mock = InsightPresenterDelegateMock(expectation: self.expectation!)
        self.sut = InsightPresenterBuilder.build(delegate: mock)
        self.sut?.didFailFetchingDocument()
        
        wait(for: [expectation!], timeout: 2)
    }
}

class InsightPresenterRecorderInteractorDelegateTests: XCTestCase {
    
    private var sut: InsightRecorderInteractorDelegate?
    private var expectation: XCTestExpectation?
    
    override func tearDown() {
        self.sut = nil
        self.expectation = nil
    }
    
    func testBroadcastEnded() {
        self.expectation = XCTestExpectation(description: "test broadcast ended")
        let mock = InsightPresenterDelegateMock(expectation: self.expectation!)
        self.sut = InsightPresenterBuilder.build(delegate: mock)
        self.sut?.broadcastEnded()
        
        wait(for: [expectation!], timeout: 2)
    }
    
    func testStartBroadcast() {
        self.expectation = XCTestExpectation(description: "test start broadcast")
        let mock = InsightPresenterDelegateMock(expectation: self.expectation!)
        self.sut = InsightPresenterBuilder.build(delegate: mock)
        self.sut?.startBroadcast()
        
        wait(for: [expectation!], timeout: 2)
    }
    
    func testStartRecording() {
        self.expectation = XCTestExpectation(description: "test start recording")
        let mock = InsightPresenterDelegateMock(expectation: self.expectation!)
        self.sut = InsightPresenterBuilder.build(delegate: mock)
        self.sut?.startBroadcast()
        
        wait(for: [expectation!], timeout: 2)
    }
    
    func testStopRecording() {
        self.expectation = XCTestExpectation(description: "test stop recording")
        let mock = InsightPresenterDelegateMock(expectation: self.expectation!)
        self.sut = InsightPresenterBuilder.build(delegate: mock)
        self.sut?.stopRecording()
        
        wait(for: [expectation!], timeout: 2)
    }
}

private class InsightPresenterDelegateMock: InsightPresenterDelegate {
    
    var expectation: XCTestExpectation?
    
    convenience init(expectation: XCTestExpectation) {
        self.init()
        self.expectation = expectation
    }
    
    func presentPDFPage(page: PDFPageViewModel) {
        self.expectation?.fulfill()
    }
    
    func configureViewForPDF(page: PDFPageViewModel) {
        self.expectation?.fulfill()
    }
    
    func presentError() {
        self.expectation?.fulfill()
    }
    
    func showLoading() {
        self.expectation?.fulfill()
    }
    
    func hideLoading() {
        self.expectation?.fulfill()
    }
    
    func startBroadcast() {
        self.expectation?.fulfill()
    }
    
    func broadcastEnded() {
        self.expectation?.fulfill()
    }
    
    func startRecording() {
        self.expectation?.fulfill()
    }
    
    func stopRecording() {
        self.expectation?.fulfill()
    }
}
