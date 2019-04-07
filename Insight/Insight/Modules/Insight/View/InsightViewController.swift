//
//  InsightViewController.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import UIKit
import ReplayKit


class InsightViewController: UIViewController {
    
    @IBOutlet weak var recordBarView: RecordBarView!
    
    private var presenter: InsightPresenterProtocol?
    
    private let controller = RPBroadcastController()
    private let recorder = RPScreenRecorder.shared()
    
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
        self.recordBarView.delegate = self
    }
}

extension InsightViewController: InsightPresenterOutputProtocol {
   
    func startRecording() {
        loadBoradcastActivityViewController()
    }
    
    func recordEnded() {
        broadcastEnded()
    }
}

extension InsightViewController: RecordBarDelegate {
  
    func didTapCameraButton() {
        print("CAMERA")
    }
    
    func didTapRecordButton() {
        self.presenter?.didTapRecordButton()
    }
}

extension InsightViewController: RPBroadcastActivityViewControllerDelegate {
    
    func broadcastActivityViewController(_ broadcastActivityViewController: RPBroadcastActivityViewController,
                                         didFinishWith broadcastController: RPBroadcastController?, error: Error?) {
        
        guard error == nil else { return }
        showActivityIndicator()
        broadcastActivityViewController.dismiss(animated: true) {
            broadcastController?.startBroadcast { error in
                guard error == nil else { return }
                print("Broadcast started successfully!")
                self.dismissAlert()
                self.broadcastStarted()
            }
        }
    }
    
    private func loadBoradcastActivityViewController() {
        RPBroadcastActivityViewController.load { broadcastAVC, error in
            guard error == nil else {
                print("Cannot load Broadcast Activity View Controller.")
                return
            }
            if let broadcastAVC = broadcastAVC {
                broadcastAVC.delegate = self
                self.present(broadcastAVC, animated: true, completion: nil)
            }
        }
    }
    
    private func showActivityIndicator() {
        let waitView = UIAlertController(title: nil, message: "Aguarde...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()

        waitView.view.addSubview(loadingIndicator)
        present(waitView, animated: true, completion: nil)
    }
    
    private func dismissAlert() {
        dismiss(animated: false, completion: nil)
    }
    
    private func broadcastStarted() {
        recordBarView.didStartRecording()
    }
    
    private func broadcastEnded() {
        recordBarView.didStopRecording()
    }
}
