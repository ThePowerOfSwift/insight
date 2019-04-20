//
//  LaserPointerView.swift
//  Insight
//
//  Created by Douglas Mandarino on 20/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


class LaserPointerView: UIView {
    
    @IBOutlet var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        loadNib()
        containerView.fixInView(self)
    }
}


// MARK: - UIGestureRecognizer

extension LaserPointerView {
    
    func didMove(in superView: UIView, recognizer: UIPanGestureRecognizer) {
        setDefaultPosition(superView: superView, recognizer: recognizer)
        switch recognizer.state {
        case .began:
            superView.addSubview(self)
        case .changed:
            didChange(recognizer: recognizer)
        default:
            self.removeFromSuperview()
        }
    }
    
    private func setDefaultPosition(superView: UIView, recognizer: UIPanGestureRecognizer) {
        let pointInSuperView = recognizer.location(in: superView)
        self.center = CGPoint(x: pointInSuperView.x, y: pointInSuperView.y - 44)
        self.frame.size = CGSize(width: 24, height: 24)
    }
    
    private func didChange(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        let xPoint = self.frame.midX + translation.x
        let yPoint = self.frame.midY + translation.y
        self.center = CGPoint(x: xPoint, y: yPoint)
        recognizer.setTranslation(.zero, in: self)
    }
}
