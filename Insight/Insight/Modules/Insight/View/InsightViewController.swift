//
//  InsightViewController.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import UIKit
import ReplayKit
import MobileCoreServices


// MARK: - InsightViewController

class InsightViewController: UIViewController {
    
    @IBOutlet weak var recordBarView: RecordBarView!
    @IBOutlet weak var toolBarView: ToolBarView!
    
    private var presenter: InsightPresenterProtocol?
    private var isRecording: Bool = false
    private var isReplayKitOff: Bool = true
    private var isCamHidden: Bool = true
    private var isLaserPointerSelected: Bool = false
    private var camView = CamView()
    private var laserPointerView = LaserPointerView()
    private var pdfView: UIImageView = UIImageView()
    private var backgroundView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInsightViewController()
    }
    
    func setupViewController(with presenter: InsightPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func configureInsightViewController() {
        RPScreenRecorder.shared().isMicrophoneEnabled = true
        self.recordBarView.delegate = self
        self.toolBarView.delegate = self
        self.camView.setup(for: self.view)
        configureGestures()
    }
    
    private func dismissAlert() {
        dismiss(animated: false, completion: nil)
    }
}


// MARK: - InsightPresenterDelegate

extension InsightViewController: InsightPresenterDelegate {
    
    func showLoading() {
        showActivityIndicator()
    }
    
    func hideLoading() {
        dismissAlert()
    }
    
    func presentPDFPage(page: PDFPageViewModel) {
        self.pdfView.image = page.image
        self.pdfView.frame.size = self.view.safeAreaLayoutGuide.layoutFrame.size
        self.pdfView.center = self.view.center
        self.pdfView.setNeedsDisplay()
        self.view.addSubview(self.pdfView)
        self.view.sendSubviewToBack(self.pdfView)
        self.view.sendSubviewToBack(self.backgroundView)
    }
    
    func configureViewForPDF(page: PDFPageViewModel) {
        self.backgroundView = UIImageView(image: page.image)
        self.backgroundView.addBlurEffect()
        self.view.addSubview(self.backgroundView)
        self.view.sendSubviewToBack(self.backgroundView)
    }
    
    func presentError() {
        showError(with: "Sorry, we couldn't download your document. Try again later, please.")
    }

    func startBroadcast() {
        RPScreenRecorder.shared().isMicrophoneEnabled = true
        loadBoradcastActivityViewController()
    }
    
    func broadcastEnded() {
        didStopReplayKit()
    }
    
    func startRecording() {
        RPScreenRecorder.shared().isMicrophoneEnabled = true
        startRecordingScreen()
    }
    
    func stopRecording() {
        stopRecordingScreen()
    }
}


// MARK: - RecordBarDelegate

extension InsightViewController: ToolBarDelegate {
    
    func didSelectImportButton() {
        presentDocumentPicker()
    }
    
    func didSelectLaserPointerButton() {
        self.isLaserPointerSelected = true
    }
    
    func didDeselectTool() {
        self.isLaserPointerSelected = false
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
        RPScreenRecorder.shared().isMicrophoneEnabled = !RPScreenRecorder.shared().isMicrophoneEnabled
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
            self.presenter?.didTapRecordButton(toBroadcast: true)
        }
        let recordAction = UIAlertAction(title: "Recording", style: .default) { _ in
            self.presenter?.didTapRecordButton(toBroadcast: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
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
}


// MARK: - RPPreviewViewControllerDelegate

extension InsightViewController: RPPreviewViewControllerDelegate {
    
    func startRecordingScreen() {
        self.showActivityIndicator()
        guard RPScreenRecorder.shared().isAvailable else {
            self.showError(with: "Recording is not available at this time")
            return
        }
        
        RPScreenRecorder.shared().isMicrophoneEnabled = true
        
        RPScreenRecorder.shared().startRecording{ [unowned self] (error) in
            DispatchQueue.main.async {
                self.didStartReplayKit(error: error)
                self.isRecording = true
            }
        }
        self.dismissAlert()
    }

    func stopRecordingScreen() {
        guard RPScreenRecorder.shared().isAvailable else {
            self.showError(with: "Recording is not available at this time")
            return
        }

        RPScreenRecorder.shared().stopRecording { [unowned self] (preview, error) in
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
            RPScreenRecorder.shared().discardRecording {}
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


// MARK: - UIDocumentPickerDelegate

extension InsightViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.presenter?.didSelectToImport(from: url)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
    }
    
    private func presentDocumentPicker() {
        let importMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .popover
        self.present(importMenu, animated: true, completion: nil)
    }
    
    @objc private func presentAnotherPage(recognizer: UITapGestureRecognizer) {
        if recognizer.location(in: self.view).x > self.view.center.x {
            self.presenter?.didDoubleTapped(leftSide: false)
        } else {
            self.presenter?.didDoubleTapped(leftSide: true)
        }
    }
}


// MARL: - Privates

extension InsightViewController {
    private func didStartReplayKit(error: Error?) {
        guard error == nil else {
            self.showError(with: "Couldn't start broadcast.")
            return
        }
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
    
    private func showError(with message: String) {
        let alert = UIAlertController(title: "Something happened", message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}
