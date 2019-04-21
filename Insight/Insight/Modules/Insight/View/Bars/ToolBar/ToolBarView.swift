//
//  ToolBarView.swift
//  Insight
//
//  Created by Douglas Mandarino on 19/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


protocol ToolBarDelegate: class {
    func didSelectImportButton()
    func didSelectLaserPointerButton()
    func didDeselectTool()
}


class ToolBarView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var importButton: InsightButton!
    @IBOutlet private weak var laserPointerButton: InsightButton!
    
    weak var delegate: ToolBarDelegate?
    private var originalLaserPointerPosition: CGPoint = .zero
    private var isToolBarSelected: Bool = false
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    @IBAction func didTapImportButton(_ sender: InsightButton) {
        self.delegate?.didSelectImportButton()
    }
    
    @IBAction func didTapLaserPointerButton(_ sender: InsightButton) {
        didTap(button: self.laserPointerButton)
        self.isToolBarSelected ? self.delegate?.didSelectLaserPointerButton() : self.delegate?.didDeselectTool()
    }
    
    private func didTap(button: InsightButton) {
        self.contentView.bringSubviewToFront(button)
        self.contentView.layoutSubviews()
        self.isToolBarSelected = !self.isToolBarSelected
        if self.isToolBarSelected {
            UIView.animate(withDuration: 0.4, animations: {
                self.laserPointerButton.frame.origin = .zero
            })
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.laserPointerButton.frame.origin = self.originalLaserPointerPosition
            })
        }
    }
    
    private func configureView() {
        loadNib()
        contentView.fixInView(self)
        self.originalLaserPointerPosition = self.laserPointerButton.frame.origin
    }
}
