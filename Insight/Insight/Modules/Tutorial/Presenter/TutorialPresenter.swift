//
//  TutorialPresenter.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


final class TutorialPresenter {
    
    private var wireframe: TutorialWireframeProtocol?
    private weak var delegate: TutorialPresenterDelegate?
    private var steps: [TutorialStep] = []
    private var stepIndex: Int = 0
    
    init(wireframe: TutorialWireframeProtocol, delegate: TutorialPresenterDelegate) {
        self.wireframe = wireframe
        self.delegate = delegate
    }
}

extension TutorialPresenter: TutorialPresenterProtocol {
    
    func viewDidLoad() {
        self.steps = TutorialMapper.makeTutorialSteps()
    }
    
    func didTapToStartInsight() {
        self.wireframe?.presentInsight()
    }
    
    func didTapNext() {
        guard self.stepIndex + 1 <= steps.count else { return }
        let step = steps[self.stepIndex]
        self.delegate?.presentStep(with: step)
        self.stepIndex += 1
        changeSkipButtonIfNeeded()
    }
    
    private func changeSkipButtonIfNeeded() {
        guard self.stepIndex == steps.count else { return }
        self.delegate?.changeSkipButton()
    }
}
