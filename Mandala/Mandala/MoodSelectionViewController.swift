//
//  ViewController.swift
//  Mandala
//
//  Created by Robert Whitewick on 03/05/2023.
//

import UIKit

class MoodSelectionViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var addMoodButton: UIButton!
    
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
            moodButtons = moods.map { mood in
                let moodButton = UIButton()
                moodButton.setImage(mood.image, for: .normal)
                moodButton.imageView?.contentMode = .scaleAspectFit
                moodButton.adjustsImageWhenHighlighted = false
                moodButton.addTarget(self,
                                     action: #selector(moodSelectionChanged(_:)),
                                     for: .touchUpInside)
                return moodButton
                
            }
        }
    }
    
    
    var moodButtons: [UIButton] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            moodButtons.forEach { stackView.addArrangedSubview($0) }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
        
            addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)
            addMoodButton?.backgroundColor = currentMood.colour
        }
    }
    
    @objc func moodSelectionChanged(_ sender: UIButton) {
        guard let selectedindex = moodButtons.firstIndex(of: sender) else {
            preconditionFailure("Unable to find the tapped button in the buttons array")
        }
        
        currentMood = moods[selectedindex]
    }


}

