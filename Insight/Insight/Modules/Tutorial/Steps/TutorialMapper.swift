//
//  TutorialMapper.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct TutorialMapper {
    
    static func makeTutorialSteps() -> [TutorialStep] {
        return [
            makeMainTitleStep(),
            makeImportStep(),
            makePdfNavigationStep(),
            makeLaserPointerStep(),
            makeLiveOrRecordStep(),
            makeWebCamStep(),
            makeMicrophoneStep()
        ]
    }
    
    static private func makeMainTitleStep() -> TutorialStep {
        return TutorialStep(title: "Welcome to Insight!",
                            description: "Right here you have all the tools needed to create an awesome and creative video lesson. Share your thoughts and knowledge with this wonderful software created with you in mind. Everyone has something to teach. Do it with Insight.",
                            step: .mainTitle)
    }
    
    static private func makeImportStep() -> TutorialStep {
        return TutorialStep(title: "Import",
                            description: "It is said that one image is worth a bunch of words. If you want to reuse that killer presentation, there is the possibility to import it as a PDF.",
                            step: .importStep)
    }
    
    static private func makePdfNavigationStep() -> TutorialStep {
        return TutorialStep(title: "Navigate in PDF",
                            description: "Probably your presentation will have more than one page. You can go forward and backwards by swiping in the screen or double tapping on the right and the left side of the screen.",
                            step: .pdfNavigatonStep)
    }
    
    static private func makeLaserPointerStep() -> TutorialStep {
        return TutorialStep(title: "Laser Pointer",
                            description: "Laser Pointer is an excellent tool for drawing attention to a specific spot on the screen. This feature enables you to indicate where is the current focus.",
                            step: .laserPointerStep)
    }
    
    static private func makeLiveOrRecordStep() -> TutorialStep {
        return TutorialStep(title: "Live or Record",
                            description: "This is the Record Button. When tapped, you will be asked whether you want to start recording or going live, with or without audio. After that, everything that happens inside your screen will be broadcasted/recorded. A second tap stops and shows you the resulting video.",
                            step: .recordOrLiveStep)
    }
    
    static private func makeWebCamStep() -> TutorialStep {
        return TutorialStep(title: "WebCam",
                            description: "You might want to show your face to the world. So, you can use front cam while recording or during your lives. Pinch to resize it as you please and don't worry, you can drag the cam to be anywhere.",
                            step: .webCamStep)
    }
    
    static private func makeMicrophoneStep() -> TutorialStep {
        return TutorialStep(title: "Microphone",
                            description: "You can always mute and unmute yourself. It's in your hand. But I bet your audience would love hear your voice.",
                            step: .microphoneStep)
    }
}
