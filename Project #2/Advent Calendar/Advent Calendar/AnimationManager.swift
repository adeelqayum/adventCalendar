//
//  AnimationManager.swift
//  Advent Calendar
//
//  Created by Adeel Qayum on 10/30/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import Foundation
import UIKit

protocol AnimationManagerDelegate: class  {
    func shouldFlip(_ animationmanager: AnimationManager, index: Int) -> Bool
    func didFlip(_ animationmanager: AnimationManager, index: Int)
}

class AnimationManager: UIView {
    
    @IBOutlet weak var tilelabel: UILabel!
    
    weak var delegate: AnimationManagerDelegate?
    
    var index = 0
    
    var title: String = "" {
        didSet {
            tilelabel.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Animations
    
    func animateAlphaFade() {
        UIView.animate(withDuration: 1.2, animations: {
            self.alpha = 0.0
        })
    }
    
    func animateFlipBack() {
        UIView.transition(
            with: self,
            duration: 0.5,
            options: [.transitionFlipFromRight],
            animations: {
                self.title = ""
        })
    }
    
    func animateFlip() {
        UIView.transition(
            with: self,
            duration: 0.5,
            options: [.transitionFlipFromLeft],
            animations: {
                self.delegate?.didFlip(self, index: self.index)
        })
    }
    
    // MARK: - Gestures
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        if (delegate?.shouldFlip(self, index: self.index))! {
            animateFlip()
        }
    }
}
