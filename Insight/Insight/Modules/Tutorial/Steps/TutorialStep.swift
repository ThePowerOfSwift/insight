//
//  Tutorial.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


enum Step {
    case importStep
    case laserPointerStep
    case recordOrLiveStep
    case pdfNavigatonStep
    case webCamStep
    case microphoneStep
}

struct TutorialStep {
    var title: String
    var description: String
    var step: Step
}
