//
//  InsightDocmentInteractorTests.swift
//  InsightTests
//
//  Created by Douglas Mandarino on 13/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import XCTest
@testable import Insight

class InsightDocmentInteractorTests: XCTestCase {
    
    private var sut: InsightDocumentInteractor?
    private var url: URL = URL(string: "http://www.orimi.com/pdf-test.pdf")!
    private var expectation: XCTestExpectation?
    
    override func setUp() {
        self.sut = InsightDocumentInteractorBuilder.build()
    }
    
    override func tearDown() {
        self.sut = nil
        self.expectation = nil
    }
    
    func testDownloadURL() {
        self.expectation = XCTestExpectation(description: "test download URL")
        let mock = InsightPresenterMock(expectation: self.expectation!)
        self.sut?.setupInteractor(with: mock)
        self.sut?.fetchPresentation(for: url)
        
        wait(for: [expectation!], timeout: 2)
    }
    
    func testDownloadURLFailed() {
        self.expectation = XCTestExpectation(description: "test download URL failed")
        let mock = InsightPresenterMock(expectation: self.expectation!)
        self.sut?.setupInteractor(with: mock)
        self.sut?.fetchPresentation(for: URL(string: "http://testfail.com")!)
        
        wait(for: [expectation!], timeout: 2)
    }
}

private class InsightPresenterMock: InsightDocumentInteractorDelegate {
    
    var expectation: XCTestExpectation?
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func didFetchDocument(document: PDFDocument) {
        self.expectation?.fulfill()
    }
    
    func didFailFetchingDocument() {
        self.expectation?.fulfill()
    }
}
