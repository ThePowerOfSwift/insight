//
//  InsightPresenter.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import ReplayKit


final class InsightPresenter {
    
    private var recordInteractor: InsightRecorderInteractorProtocol?
    private var documentInteractor: InsightDocumentInteractorProtocol?
    private weak var delegate: InsightPresenterDelegate?
    
    private var pages = [PDFPageViewModel]()
    private var selectedPage: PDFPageViewModel?
    
    init(recordInteractor: InsightRecorderInteractorProtocol,
         documentInteractor: InsightDocumentInteractorProtocol,
         delegate: InsightPresenterDelegate) {
        self.recordInteractor = recordInteractor
        self.documentInteractor = documentInteractor
        self.delegate = delegate
    }
}

extension InsightPresenter: InsightPresenterProtocol {

    func didSelectToImport(from url: URL) {
        self.delegate?.showLoading()
        self.documentInteractor?.fetchPresentation(for: url)
    }
    
    func didTapRecordButton(toBroadcast: Bool) {
        toBroadcast ? self.recordInteractor?.startOrStopBroadcast() : self.recordInteractor?.startOrStopRecording()
    }
    
    func didDoubleTapped(leftSide: Bool) {
        leftSide ? presentPreviousPage() : presentNextPage()
    }
    
    private func presentNextPage() {
        guard let index = getCurrentPdfPage(), index < self.pages.count - 1 else { return }
        self.selectedPage = self.pages[index + 1]
        self.delegate?.presentPDFPage(page: self.selectedPage!)
    }
    
    private func presentPreviousPage() {
        guard let index = getCurrentPdfPage(), index > 0 else { return }
        self.selectedPage = self.pages[index - 1]
        self.delegate?.presentPDFPage(page: self.selectedPage!)
    }
    
    private func getCurrentPdfPage() -> Int? {
        return self.pages.firstIndex(where: { $0.image == selectedPage?.image })
    }
}

extension InsightPresenter: InsightRecorderInteractorDelegate {
    
    func startRecording() {
        self.delegate?.startRecording()
    }
    
    func stopRecording() {
        self.delegate?.stopRecording()
    }
    
    func startBroadcast() {
        self.delegate?.startBroadcast()
    }
    
    func broadcastEnded() {
        self.delegate?.broadcastEnded()
    }
    
    private func presentFirstPage() {
        guard let page = self.pages.first else { return }
        self.selectedPage = page
        self.delegate?.presentPDFPage(page: page)
        self.delegate?.configureViewForPDF(page: page)
    }
}

extension InsightPresenter: InsightDocumentInteractorDelegate {
    
    func didFetchDocument(document: PDFDocument) {
        self.delegate?.hideLoading()
        self.pages = PDFPageViewModelMapper.make(from: document)
        guard !self.pages.isEmpty else { return }
        presentFirstPage()
    }
    
    func didFailFetchingDocument() {
        self.delegate?.presentError()
    }
}
