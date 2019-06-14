//
//  PDFDocumentMock.swift
//  InsightTests
//
//  Created by Douglas Mandarino on 14/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import XCTest
@testable import Insight

class PDFDocumentMapperMock {
    
    static func create() -> PDFDocument {
        let pages = createPages()
        let pdfDocument = PDFDocument(pages: pages)
        return pdfDocument
    }
    
    static private func createPages() -> [PDFPage] {
        
        return [PDFPage(pageNumber: 1, page: UIImage()),
                PDFPage(pageNumber: 2, page: UIImage()),
                PDFPage(pageNumber: 3, page: UIImage()),
                PDFPage(pageNumber: 4, page: UIImage()),
                PDFPage(pageNumber: 5, page: UIImage())
        ]
    }
}
