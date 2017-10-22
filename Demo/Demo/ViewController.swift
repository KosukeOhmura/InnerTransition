//
//  ViewController.swift
//  Demo
//
//  Created by Ohmura Kosuke on 2017/10/22.
//  Copyright © 2017年 KosukeOhmura. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // transition types and directions
    
    private lazy var transitionTypeName: String = transitionTypeNames[0]
    private lazy var transitionFrom: InnerTransition.From = transitionFromNamePairs[0].from
    
    private let transitionTypeNames: [String] = ["fade", "moveIn", "push", "reveal"]
    private let transitionFromNamePairs: [(name: String, from: InnerTransition.From)] = [("right", .right), ("left", .left), ("top", .top), ("bottom", .bottom)]
    
    // IBOutlets
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var durationSlider: UISlider!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var fromSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var transitButton: UIButton!
    
    // prepare demo datas and setup slider and segmentedControls
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        durationSlider.value = 0.25
        updateDurationLabel(durationSlider.value)
        durationSlider.maximumValue = 3
        
        fromSegmentedControl.removeAllSegments()
        transitionFromNamePairs.enumerated().forEach { (index, pair) in
            fromSegmentedControl.insertSegment(withTitle: pair.name, at: index, animated: false)
        }
        fromSegmentedControl.selectedSegmentIndex = 0
        
        typeSegmentedControl.removeAllSegments()
        transitionTypeNames.enumerated().forEach { (index, typeName) in
            typeSegmentedControl.insertSegment(withTitle: typeName, at: index, animated: false)
        }
        typeSegmentedControl.selectedSegmentIndex = 0
        
        updateIsFromEnabled(typeName: transitionTypeNames[0])
    }
    
    // transit
    
    @IBAction private func didTransitButtonTap(_ sender: UIButton) {
        let duration = Double(self.durationSlider.value)
        
        switch self.transitionTypeName {
        case "fade":
            label.fade(duration: duration, transitions: { $0.text = getSampleText() })
            imageView.fade(duration: duration, transitions: { $0.image = getSampleImage() })
            
        case "moveIn":
            label.moveIn(from: transitionFrom, duration: duration, transitions: { $0.text = getSampleText() })
            imageView.moveIn(from: transitionFrom, duration: duration, transitions: { $0.image = getSampleImage() })
            
        case "push":
            label.push(from: transitionFrom, duration: duration, transitions: { $0.text = getSampleText() })
            imageView.push(from: transitionFrom, duration: duration, transitions: { $0.image = getSampleImage() })
            
        case "reveal":
            label.reveal(from: transitionFrom, duration: duration, transitions: { $0.text = getSampleText() })
            imageView.reveal(from: transitionFrom, duration: duration, transitions: { $0.image = getSampleImage() })
            
        default:
            break
            
        }
    }
    
    // event handlers for slider and segmentedControls
    
    @IBAction private func didDurationSliderChange(_ sender: UISlider) {
        updateDurationLabel(sender.value)
    }
    
    @IBAction private func didFromSegmentChange(_ sender: UISegmentedControl) {
        transitionFrom = transitionFromNamePairs[sender.selectedSegmentIndex].from
    }
    
    @IBAction private func didTypeSegmentChange(_ sender: UISegmentedControl) {
        let transitionTypeName = transitionTypeNames[sender.selectedSegmentIndex]
        self.transitionTypeName = transitionTypeName
        updateIsFromEnabled(typeName: transitionTypeName)
    }
    
    // update label and segmentedControl
    
    private func updateDurationLabel(_ newDuration: Float) {
        self.durationLabel.text = String(format: "%0.2f", newDuration)
    }
    
    private func updateIsFromEnabled(typeName: String) {
        self.fromSegmentedControl.isEnabled = "fade" != typeName
    }
    
    // sample text set
    
    private func getSampleText() -> String {
        let index: Int = {
            if showingTextIndex == sampleTexts.count - 1 {
                return 0
            } else {
                return showingTextIndex + 1
            }
        }()
        showingTextIndex = index
        
        return sampleTexts[index]
    }
    
    private var showingTextIndex = 0
    private let sampleTexts: [String] = [
        "InnerTransition",
        "It gives 4 types of transition.",
        "fade, moveIn, push and reveal.",
        "It is extention for UIView."
    ]
    
    // sample image set
    
    private func getSampleImage() -> UIImage {
        let index: Int = {
            if showingImageIndex == sampleImages.count - 1 {
                return 0
            } else {
                return showingImageIndex + 1
            }
        }()
        showingImageIndex = index
        
        return sampleImages[index]
    }
    
    private var showingImageIndex = 0
    private let sampleImages: [UIImage] = [
        UIImage(named: "Face")!,
        UIImage(named: "Fish")!,
        UIImage(named: "NoSmoking")!,
        UIImage(named: "Lift")!,
        UIImage(named: "Toilet")!,
        UIImage(named: "Departure")!
    ]
    
}

