//
//  TutorialPresenterProtocol.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


protocol TutorialPresenterProtocol {
    func viewDidLoad()
    func didTapToStartInsight()
    func didTapNext()
    func didTapPrevious()
}

protocol TutorialPresenterDelegate: class {
    func presentStep(with step: TutorialStep)
    func changeSkipButton()
}
