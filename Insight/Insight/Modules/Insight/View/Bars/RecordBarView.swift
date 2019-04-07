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
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var clockLabel: UILabel!
    
    weak var delegate: RecordBarDelegate?
    
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
    
    func commonInit() {
        loadNib()
        contentView.fixInView(self)
    }
}
