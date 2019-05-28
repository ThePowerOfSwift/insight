//
//  InsightDocumentInteractor.swift
//  Insight
//
//  Created by Douglas Mandarino on 12/05/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Protocols

protocol InsightDocumentInteractorProtocol {
    func fetchPresentation(for url: URL)
}

protocol InsightDocumentInteractorDelegate: class {
    func didFetchDocument(document: PDFDocument)
    func didFailFetchingDocument()
}


// MARK: - InsightDocumentInteractor

final class InsightDocumentInteractor {
    
    private weak var delegate: InsightDocumentInteractorDelegate?
    private var pdfDocument: PDFDocument?
    
    init() {}
    
    func setupInteractor(with delegate: InsightDocumentInteractorDelegate) {
        self.delegate = delegate
    }
}


// MARK: - InsightDocumentInteractorProtocol

extension InsightDocumentInteractor: InsightDocumentInteractorProtocol {
    
    func fetchPresentation(for url: URL) {
        DispatchQueue.global().async {
            guard let document = CGPDFDocument(url as CFURL) else {
                self.delegate?.didFailFetchingDocument()
                return
            }
            DispatchQueue.main.async {
                self.pdfDocument = PDFDocumentMapper.make(from: document)
                guard let document = self.pdfDocument, let pages = document.pages, !pages.isEmpty else {
                    self.delegate?.didFailFetchingDocument()
                    return
                }
                self.delegate?.didFetchDocument(document: document)
            }
        }
    }
}

