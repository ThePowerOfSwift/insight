//
//  InsightButton.swift
//  Insight
//
//  Created by Douglas Mandarino on 19/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


class InsightButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadius()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setRadius()
    }

    private func setRadius() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}
