//
//  PDFDocumentMapper.swift
//  Insight
//
//  Created by Douglas Mandarino on 23/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import UIKit


struct PDFDocumentMapper {
    
    static func make(from document: CGPDFDocument) -> PDFDocument {
        var pdfDocument = PDFDocument()
        var pages = [PDFPage]()
        for pageNumber in 1...document.numberOfPages {
            guard let page = document.page(at: pageNumber) else { break }
            let pdfPage = PDFPageMapper.make(page: page, pageNumber: pageNumber)
            pages.append(pdfPage)
        }
        pdfDocument.pages = pages
        return pdfDocument
    }
}
