//
//  TutorialPresenter.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


final class TutorialPresenter {
    
    private var router: TutorialRouterProtocol?
    private weak var delegate: TutorialPresenterDelegate?
    private var steps: [TutorialStep] = []
    private var stepIndex: Int = 0
    
    init(router: TutorialRouterProtocol, delegate: TutorialPresenterDelegate) {
        self.router = router
        self.delegate = delegate
    }
}

extension TutorialPresenter: TutorialPresenterProtocol {
    
    func viewDidLoad() {
        self.steps = TutorialMapper.makeTutorialSteps()
        presentStep()
    }
    
    func didTapToStartInsight() {
        self.router?.presentInsight()
    }
    
    func didTapNext() {
        self.stepIndex += 1
        guard self.stepIndex + 1 <= steps.count else {
            self.stepIndex = steps.count - 1
            return
        }
        presentStep()
        changeSkipButtonIfNeeded()
    }
    
    func didTapPrevious() {
        self.stepIndex -= 1
        guard self.stepIndex >= 0, self.steps.count > 0 else {
            self.stepIndex = 0
            return
        }
        presentStep()
    }
    
    private func presentStep() {
        let step = steps[self.stepIndex]
        self.delegate?.presentStep(with: step)
    }
    
    private func changeSkipButtonIfNeeded() {
        guard self.stepIndex == steps.count - 1 else { return }
        self.delegate?.changeSkipButton()
    }
}
