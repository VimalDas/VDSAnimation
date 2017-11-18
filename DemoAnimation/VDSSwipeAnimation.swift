//
//  VDSSwipeAnimation.swift
//  DemoAnimation
//
//  Created by Vimal Das on 18/11/17.
//  Copyright © 2017 Vimal Das. All rights reserved.
//

import UIKit

class VDSSwipeAnimation: UIView {
    
    private var viewCenter: CGPoint?
    private var screenSize: CGSize!
    
    private let swipeImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.alpha = 0
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        screenSize = UIScreen.main.bounds.size
        addPanGesture()
        
        self.addSubview(swipeImageView)
        swipeImageView.frame.size = CGSize(width: frame.size.width/2, height: frame.size.height/2)
        swipeImageView.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        
    }
    
    private func addPanGesture() {
        viewCenter = self.center
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(sender:)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func panAction(sender: UIPanGestureRecognizer) {
        let pan = sender.translation(in: self)
        self.center = CGPoint(x: self.center.x + pan.x
            , y: self.center.y + pan.y)
        sender.setTranslation(.zero, in: self)
        let xFromCenter = center.x - (screenSize.width/2)
        
        let scale = min(100/abs(xFromCenter), 1)
        transform = CGAffineTransform(rotationAngle: (xFromCenter/(screenSize.width/2))*0.61).scaledBy(x: scale, y: scale)
        if xFromCenter > 0 {
            swipeImageView.image = UIImage(named: "up")
            swipeImageView.tintColor = .green
        } else {
            swipeImageView.image = UIImage(named: "down")
            swipeImageView.tintColor = .red
        }
        
        swipeImageView.alpha = abs(xFromCenter) / (screenSize.width/2)
        
        if sender.state == .ended {
            
            if center.x < 75 {
                UIView.animate(withDuration: 0.3) {
                    self.center = CGPoint(x: self.center.x - 200, y: self.center.y + 75)
                    self.alpha = 0
                }
            } else if center.x > screenSize.width - 75 {
                UIView.animate(withDuration: 0.3) {
                    self.center = CGPoint(x: self.center.x + 200, y: self.center.y + 75)
                    self.alpha = 0
                }
            }
        }
    }
    
    func reset() {
        if let centr = viewCenter {
            UIView.animate(withDuration: 0.3) {
                self.transform = CGAffineTransform.identity
                self.alpha = 1
                self.swipeImageView.alpha = 0
                self.center = centr
            }
        }
    }
}
