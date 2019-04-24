//
//  InsightPresenter.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import ReplayKit


final class InsightPresenter {
    
    private var interactor: InsightInteractorProtocol?
    private weak var output: InsightPresenterOutputProtocol?
    
    private var pages = [PDFPageViewModel]()
    private var selectedPage: PDFPageViewModel?
    
    init(interactor: InsightInteractorProtocol, output: InsightPresenterOutputProtocol) {
        self.interactor = interactor
        self.output = output
    }
}

extension InsightPresenter: InsightPresenterProtocol {
    
    func didSelectToImport(from url: URL) {
        self.output?.showLoading()
        self.interactor?.fetchPresentation(url: url)
    }
    
    func didTapRecordButton(toBroadcast: Bool) {
        toBroadcast ? self.interactor?.startOrStopBroadcast() : self.interactor?.startOrStopRecording()
    }
    
    func didDoubleTapped(leftSide: Bool) {
        leftSide ? presentPreviousPage() : presentNextPage()
    }
    
    private func presentNextPage() {
        guard let index = getCurrentPdfPage(), index < self.pages.count - 1 else { return }
        self.selectedPage = self.pages[index + 1]
        self.output?.presentPDFPage(page: self.selectedPage!)
    }
    
    private func presentPreviousPage() {
        guard let index = getCurrentPdfPage(), index > 0 else { return }
        self.selectedPage = self.pages[index - 1]
        self.output?.presentPDFPage(page: self.selectedPage!)
    }
    
    private func getCurrentPdfPage() -> Int? {
        return self.pages.firstIndex(where: { $0.image == selectedPage?.image })
    }
}

extension InsightPresenter: InsightInteractorOutputProtocol {
    
    func didFetchDocument(document: PDFDocument) {
        self.output?.hideLoading()
        self.pages = PDFPageViewModelMapper.make(from: document)
        guard !self.pages.isEmpty else { return }
        presentFirstPage()
    }
    
    func didFailFetchingDocument() {
        self.output?.presentError()
    }
    
    func startRecording() {
        self.output?.startRecording()
    }
    
    func stopRecording() {
        self.output?.stopRecording()
    }
    
    func startBroadcast() {
        self.output?.startBroadcast()
    }
    
    func broadcastEnded() {
        self.output?.broadcastEnded()
    }
    
    private func presentFirstPage() {
        guard let page = self.pages.first else { return }
        self.selectedPage = page
        self.output?.presentPDFPage(page: page)
    }
}
