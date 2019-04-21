//
//  InsightViewController.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import UIKit
import ReplayKit


// MARK: - InsightViewController

class InsightViewController: UIViewController {
    
    @IBOutlet weak var recordBarView: RecordBarView!
    @IBOutlet weak var toolBarView: ToolBarView!
    
    private var presenter: InsightPresenterProtocol?
    
    private let controller = RPBroadcastController()
    private let recorder = RPScreenRecorder.shared()
    private var isRecording: Bool = false
    private var isReplayKitOff: Bool = true
    private var isCamHidden: Bool = true
    private var isLaserPointerSelected: Bool = false
    private var camView = CamView()
    private var laserPointerView = LaserPointerView()
    private var pdfPages: [UIImage] = []
    private var pdfImageView: [UIImageView] = []
    private var pdfCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInsightViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning triggered. If running this app on an older device, you might want to remove some apps from multitasking.")
    }
    
    func setupViewController(with presenter: InsightPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func configureInsightViewController() {
        self.recorder.isMicrophoneEnabled = true
        self.recordBarView.delegate = self
        self.toolBarView.delegate = self
        self.camView.setup(for: self.view)
        configureGestures()
    }
    
    private func dismissAlert() {
        dismiss(animated: false, completion: nil)
    }
}


// MARK: - InsightPresenterOutputProtocol

extension InsightViewController: InsightPresenterOutputProtocol {

    func startBroadcast() {
        self.recorder.isMicrophoneEnabled = true
        loadBoradcastActivityViewController()
    }
    
    func broadcastEnded() {
        didStopReplayKit()
    }
    
    func startRecording() {
        self.recorder.isMicrophoneEnabled = true
        startRecordingScreen()
    }
    
    func stopRecording() {
        stopRecordingScreen()
    }
}


// MARK: - RecordBarDelegate

extension InsightViewController: ToolBarDelegate {
    
    func didSelectImportButton() {
        showActivityIndicator()
        DispatchQueue.global().async {
            let url = URL(string: "http://www.inf.puc-rio.br/~coordbac/Alunos/ProjetoFinal/Manual-Aluno-Projeto-Final.pdf")!
            guard let document = CGPDFDocument(url as CFURL) else { return }
            self.pdfPages = self.drawPages(from: document)
            self.presentPDF(pageNumber: 1)
        }
    }
    
    func didSelectLaserPointerButton() {
        self.isLaserPointerSelected = true
    }
    
    func didDeselectTool() {
        self.isLaserPointerSelected = false
    }
    
    private func presentPDF(pageNumber: Int) {
        DispatchQueue.main.async {
            guard pageNumber <= self.pdfPages.count else { return }
            let imageView = UIImageView(image: self.pdfPages[pageNumber-1])
            imageView.frame.size = CGSize(width: imageView.frame.width, height: self.view.frame.height)
            imageView.center = self.view.center
            self.pdfImageView.append(imageView)
            self.view.addSubview(imageView)
            self.view.bringSubviewToFront(self.toolBarView)
            self.view.bringSubviewToFront(self.recordBarView)
            self.pdfCount += 1
            self.dismissAlert()
        }
    }
    
    private func removePdf(pageNumber: Int) {
        DispatchQueue.main.async {
            guard pageNumber >= 0 else { return }
            self.pdfImageView[pageNumber].removeFromSuperview()
            self.view.layoutSubviews()
            self.pdfCount -= 1
        }
    }
    
    @objc private func presentAnotherPage(recognizer: UITapGestureRecognizer) {
        if recognizer.location(in: self.view).x > self.view.center.x {
            presentPDF(pageNumber: pdfCount + 1)
        } else {
            removePdf(pageNumber: pdfCount - 1)
        }
    }
}


// MARK: - RecordBarDelegate

extension InsightViewController: RecordBarDelegate {
  
    func didTapCameraButton() {
        self.isCamHidden ? showCam() : closeCam()
        self.isCamHidden = !self.isCamHidden
        self.view.bringSubviewToFront(self.recordBarView)
    }
    
    func didTapRecordButton() {
        if self.isReplayKitOff {
            showActionSheetToChooseReplayKitStyle()
        } else {
            self.presenter?.didTapRecordButton(toBroadcast: self.isRecording ? false : true)
        }
    }
    
    func didTapMicrophoneButton() {
        self.recorder.isMicrophoneEnabled = !self.recorder.isMicrophoneEnabled
    }
    
    private func showCam() {
        self.camView.show(completion: { self.recordBarView.didOpenCam() })
        self.view.bringSubviewToFront(self.camView)
    }
    
    private func closeCam() {
        self.camView.show(completion: { self.recordBarView.didCloseCam() })
    }
    
    private func showActionSheetToChooseReplayKitStyle() {
        let alert = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        let broadcastAction = UIAlertAction(title: "Broadcast", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
            self.presenter?.didTapRecordButton(toBroadcast: true)
        }
        let recordAction = UIAlertAction(title: "Recording", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
            self.presenter?.didTapRecordButton(toBroadcast: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(broadcastAction)
        alert.addAction(recordAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - RPBroadcastActivityViewControllerDelegate

extension InsightViewController: RPBroadcastActivityViewControllerDelegate {
    
    func broadcastActivityViewController(_ broadcastActivityViewController: RPBroadcastActivityViewController,
                                         didFinishWith broadcastController: RPBroadcastController?, error: Error?) {
        
        guard error == nil else {
            self.showError(with: "Couldn't start broadcast.")
            return
        }
    
        broadcastActivityViewController.dismiss(animated: true) {
            broadcastController?.startBroadcast { error in
                DispatchQueue.main.async {
                    self.didStartReplayKit(error: error)
                }
            }
        }
    }
    
    private func loadBoradcastActivityViewController() {
        RPBroadcastActivityViewController.load { broadcastAVC, error in
            guard error == nil else {
                self.showError(with: "Cannot load Broadcast Activity.")
                return
            }
            if let broadcastAVC = broadcastAVC {
                broadcastAVC.delegate = self
                self.present(broadcastAVC, animated: true, completion: nil)
            }
        }
    }
    
    private func showError(with message: String) {
        dismiss(animated: false, completion: nil)
        let alert = UIAlertController(title: "Something happened", message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Ok", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - RPPreviewViewControllerDelegate

extension InsightViewController: RPPreviewViewControllerDelegate {
    
    func startRecordingScreen() {
        self.showActivityIndicator()
        guard self.recorder.isAvailable else {
            self.showError(with: "Recording is not available at this time")
            return
        }
        
        self.recorder.isMicrophoneEnabled = true
        
        self.recorder.startRecording{ [unowned self] (error) in
            DispatchQueue.main.async {
                self.didStartReplayKit(error: error)
                self.isRecording = true
            }
        }
        self.dismissAlert()
    }

    func stopRecordingScreen() {
        guard self.recorder.isAvailable else {
            self.showError(with: "Recording is not available at this time")
            return
        }

        recorder.stopRecording { [unowned self] (preview, error) in
            DispatchQueue.main.async {
                guard preview != nil else {
                    self.showError(with: "Preview controller is not available.")
                    return
                }
                self.didStopReplayKit()
                self.presentDidFinishRecord(preview: preview!)
            }
        }
    }
    
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true)
    }
    
    private func didStartRcording() {
        self.recordBarView.didStartRecording()
    }
    
    private func presentDidFinishRecord(preview: RPPreviewViewController) {
        let alert = UIAlertController(title: "Recording Finished", message: "Would you like to edit or delete your recording?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.recorder.discardRecording {}
        })
        
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: { _ in
            preview.previewControllerDelegate = self
            self.present(preview, animated: true, completion: nil)
        })
        
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
    }
}


// MARK: - UIGestureRecognizerDelegate

extension InsightViewController: UIGestureRecognizerDelegate {
    
    @objc private func trackLaserPointer(recognizer: UIPanGestureRecognizer) {
        if isLaserPointerSelected {
            self.laserPointerView.didMove(in: self.view, recognizer: recognizer)
        }
    }
    
    private func configureGestures() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(trackLaserPointer(recognizer:)))
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(presentAnotherPage(recognizer:)))
        
        pan.delegate = self
        doubleTap.delegate = self
        
        doubleTap.numberOfTapsRequired = 2
        
        self.view.addGestureRecognizer(pan)
        self.view.addGestureRecognizer(doubleTap)
    }
}


// MARK: - PDF

extension InsightViewController {
    
    private func drawPages(from document: CGPDFDocument) -> [UIImage] {
        var pages: [UIImage?] = []
        for pageNumber in 0...document.numberOfPages {
            pages.append(drawNextPage(from: document, page: pageNumber))
        }
        return pages.compactMap { $0 }
    }
    
    private func drawNextPage(from document: CGPDFDocument, page: Int) -> UIImage? {
        guard let page = document.page(at: page) else { return nil }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
        }
        
        return img
    }
}


// MARL: - Privates

extension InsightViewController {
    
    private func didStartReplayKit(error: Error?) {
        guard error == nil else {
            self.showError(with: "Couldn't start broadcast.")
            return
        }
        self.dismissAlert()
        self.recordBarView.didStartRecording()
        self.isReplayKitOff = false
    }
    
    private func didStopReplayKit() {
        self.recordBarView.didStopRecording()
        self.isRecording = false
        self.isReplayKitOff = true
    }
    
    private func showActivityIndicator() {
        let waitView = UIAlertController(title: nil, message: "Wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        
        waitView.view.addSubview(loadingIndicator)
        present(waitView, animated: true, completion: nil)
    }
}
