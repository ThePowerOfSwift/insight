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
    
    private var toogleTest: Bool = true
    
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
    
}

extension InsightViewController: RecordBarDelegate {
  
    func didTapCameraButton() {
        print("CAMERA")
    }
    
    func didTapRecordButton() {
        print("RECORD")
        if toogleTest {
            recordBarView.didStartRecording()
            toogleTest = false
        } else {
            recordBarView.didStopRecording()
            toogleTest = true
        }
//        controller.isBroadcasting ? stopBroadcast() : startBroadcast()
    }
}

extension InsightViewController: RPBroadcastActivityViewControllerDelegate {
    
    func broadcastActivityViewController(_ broadcastActivityViewController: RPBroadcastActivityViewController, didFinishWith broadcastController: RPBroadcastController?, error: Error?) {
        
        guard error == nil else {
            print("Broadcast Activity Controller is not available.")
            return
        }
        
        broadcastActivityViewController.dismiss(animated: true) {
            broadcastController?.startBroadcast { error in
                if error == nil {
                    print("Broadcast started successfully!")
                    self.broadcastStarted()
                }
            }
        }
    }
    
    private func startBroadcast() {
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
    
    private func stopBroadcast() {
        controller.finishBroadcast { error in
            if error == nil {
                print("Broadcast ended")
                self.broadcastEnded()
            }
        }
    }
    
    private func broadcastStarted() {
        recordBarView.didStartRecording()
    }
    
    private func broadcastEnded() {
        recordBarView.didStartRecording()
    }
}
