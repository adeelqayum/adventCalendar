//
//  TileView.swift
//  Advent Calendar
//
//  Created by Adeel Qayum on 10/30/18.
//  Copyright © 2018 Adeel Qayum. All rights reserved.
//

import UIKit

protocol TileViewDelegate: class  {
    func shouldFlip(_ tileView: TileView, index: Int) -> Bool
    func didFlip(_ tileView: TileView, index: Int)
}

class TileView: UIView {

    @IBOutlet weak var numberLabel: UILabel!
    
    weak var delegate: TileViewDelegate?
    
    var index = 0 {
        didSet {
            numberLabel.text = String(index + 1)
        }
    }
    
    var title = "" {
        didSet {
            numberLabel.text = title
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
        animateFlip()
    }

}
