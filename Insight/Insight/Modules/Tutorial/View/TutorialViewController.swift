//
//  TutorialViewController.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet private weak var recordButton: UIButton!
    @IBOutlet private weak var webcamButton: UIButton!
    @IBOutlet private weak var laserButton: UIButton!
    @IBOutlet private weak var importButton: UIButton!
    @IBOutlet private weak var laserArrow: UIImageView!
    @IBOutlet private weak var webcamArrow: UIImageView!
    @IBOutlet private weak var recordArrow: UIImageView!
    @IBOutlet private weak var importArrow: UIImageView!
    @IBOutlet private weak var newInsightButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var textView: UITextView!
    
    private var presenter: TutorialPresenterProtocol?
    
    private var previousStepButton: UIButton?
    private var previousStepArrow: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    func setupViewController(with presenter: TutorialPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    
    
    @IBAction func newInsightTapped(sender: AnyObject) {
       self.presenter?.didTapToStartInsight()
    }
    
    @IBAction func nextTapped(sender: AnyObject) {
        self.presenter?.didTapNext()
    }
}


extension TutorialViewController: TutorialPresenterDelegate {
    
    func presentStep(with step: TutorialStep) {
        self.titleLabel.text = step.title
        self.textView.text = step.description
        presentRightIndicator(for: step.step)
        
        self.view.setNeedsDisplay()
    }
    
    func changeSkipButton() {
        self.nextButton.setTitle("Done!", for: .normal)
        self.newInsightButton.titleLabel?.text = "Done"
        self.nextButton.isHidden = true
        self.view.setNeedsDisplay()
    }
    
    private func presentRightIndicator(for step: Step) {
        switch step {
        case .importStep:
            presentIndicator(button: self.importButton, arrow: self.importArrow)
        case .laserPointerStep:
            presentIndicator(button: self.laserButton, arrow: self.laserArrow)
        case .recordOrLiveStep:
            presentIndicator(button: self.recordButton, arrow: self.recordArrow)
        case .webCamStep:
            presentIndicator(button: self.webcamButton, arrow: self.webcamArrow)
        default:
            presentIndicator(button: nil, arrow: nil)
        }
    }
    
    private func presentIndicator(button: UIButton?, arrow: UIImageView?) {
        self.previousStepButton?.alpha = 0.25
        self.previousStepArrow?.isHidden = true
        
        guard let button = button, let arrow = arrow else { return }
        button.alpha = 1
        arrow.isHidden = false
        self.previousStepButton = button
        self.previousStepArrow = arrow
    }
}

