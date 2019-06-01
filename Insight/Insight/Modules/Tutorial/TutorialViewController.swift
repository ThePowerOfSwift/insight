//
//  TutorialViewController.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var webcamButton: UIButton!
    @IBOutlet weak var laserButton: UIButton!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var laserArrow: UIImageView!
    @IBOutlet weak var webcamArrow: UIImageView!
    @IBOutlet weak var recordArrow: UIImageView!
    @IBOutlet weak var importArrow: UIImageView!
    @IBOutlet weak var newInsightButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    
    var name: [String] = []
    var text: [String] = []
    
    var i = -1

    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "welcomeTitle"
        descriptionTV.text = "welcomeDescription"
        
        name += ["penTool","highlighterTool","laserTool","importTool", "recordTool", "webcam", "helpTool", "deleteAll"]
        
        text += [
            "penDescription",
            "highlighterDescription",
            "laserDescription",
            "importDescription",
            "recordDescription",
            "webcamDescription",
            "helpDescription",
            "deleteAllDescription"]
        
    }
    
    // MARK: - Public Methods
    
    
    @IBAction func newInsightTapped(sender: AnyObject) {
        
       goToInsight()
    }
    
    @IBAction func nextTapped(sender: AnyObject) {
        
        if i <= 6 {
            i += 1
            
            titleLabel.text = "\(name[i])"
            
            descriptionTV.isSelectable = true
            descriptionTV.text = "\(text[i])"
            descriptionTV.isSelectable = false
            
            
            switch(i) {
            case 2:
                laserArrow.isHidden = false
                laserButton.alpha = 1
                
            case 3:
                laserArrow.isHidden = true
                laserButton.alpha = 0.25
                importArrow.isHidden = false
                importButton.alpha = 1
                
            case 4:
                importArrow.isHidden = true
                importButton.alpha = 0.25
                recordArrow.isHidden = false
                recordButton.alpha = 1
                
            case 5:
                recordArrow.isHidden = true
                recordButton.alpha = 0.25
                webcamArrow.isHidden = false
                webcamButton.alpha = 1
                
            case 6:
                webcamArrow.isHidden = true
                webcamButton.alpha = 0.25
                
            default:
                nextButton.setTitle("Done!", for: .normal)
            }
        }
            
        else {
            
            goToInsight()
            
        }
    }
    
    func goToInsight() {
        
//        self.present(EditScreen.instance, animated: false, completion: nil)
    }
    
    
    // MARK: - Private Methods
    
    private func setButtonBackgroundCollor() {
        //FIX-ME se mudar a cor do background, vai dar merda
        //        self.myView.penButton.backgroundColor = Color.white
        //        self.myView.highlighterButton.backgroundColor = Color.white
        //        self.myView.laserPointerButton.backgroundColor = Color.white
        //        self.myView.importButton.backgroundColor = Color.white
    }
}


