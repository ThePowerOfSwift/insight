//
//  RecordBarView.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import UIKit

protocol RecordBarDelegate: class {
    func didTapCameraButton()
    func didTapRecordButton()
}


class RecordBarView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var cameraButton: UIButton!
    @IBOutlet private weak var recordButton: UIButton!
    @IBOutlet private weak var clockLabel: UILabel!
    
    weak var delegate: RecordBarDelegate?
    private var startTime: Double = 0
    private var timer: Timer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    @IBAction func didTapCameraButton(_ sender: Any) {
        self.delegate?.didTapCameraButton()
    }
    
    @IBAction func didTapRecordButton(_ sender: Any) {
        self.delegate?.didTapRecordButton()
    }
    
    func didStartRecording() {
        self.recordButton.isSelected = true
        startClock()
    }
    
    func didStopRecording() {
        self.recordButton.isSelected = false
        stopClock()
    }
    
    private func commonInit() {
        loadNib()
        contentView.fixInView(self)
    }
    
    private func startClock() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateClockLabel), userInfo: nil, repeats: true)
        self.startTime = NSDate.timeIntervalSinceReferenceDate
        self.clockLabel.isHidden = false
    }
    
    private func stopClock() {
        self.clockLabel.text = "00:00"
        self.clockLabel.isHidden = true
        self.timer.invalidate()
        self.timer = nil
    }
    
    @objc private func updateClockLabel() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - self.startTime

        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        self.clockLabel.text = "\(strMinutes):\(strSeconds)"
    }
}
