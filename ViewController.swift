//
//  ViewController.swift
//  DemoAngleAnimaton
//
//  Created by Agstya Technologies on 04/12/17.
//  Copyright © 2017 Agstya Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:- Variables | Properties
    private var isAnimatingUpward: Bool = true
    private var upAnimator: UIViewPropertyAnimator!
    private var downAnimator: UIViewPropertyAnimator!
    
    private let heightImgViewAngel: CGFloat = 150.0
    private let heightScreen: CGFloat = UIScreen.main.bounds.size.height
    private let spacingTopAndBottom: CGFloat = 10.0
    
    // MARK:- IBOutlets
    @IBOutlet private weak var imgViewAngel: UIImageView!
    @IBOutlet private weak var btnPlayOrPause: UIButton!
    
    @IBOutlet private weak var constraintCenterYimgViewAngel: NSLayoutConstraint!
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- UI Methods
    private func setupUI() {
        constraintCenterYimgViewAngel.constant = -(spacingTopAndBottom + (heightImgViewAngel / 2) - (heightScreen / 2))
        self.view.layoutIfNeeded()
    }
    
    // MARK:- IBAction Methods
    @IBAction private func onBtnPlayOrPause(_ sender: Any) {
        if btnPlayOrPause.isSelected {
            if isAnimatingUpward {
                if upAnimator.isRunning {
                    upAnimator.pauseAnimation()
                }
            } else {
                if downAnimator.isRunning {
                    downAnimator.pauseAnimation()
                }
            }
        } else {
            if isAnimatingUpward {
                if upAnimator == nil {
                    startUpAnimation()
                } else {
                    if !upAnimator.isRunning {
                        upAnimator.startAnimation()
                    } else {
                        startUpAnimation()
                    }
                }
            } else {
                if downAnimator == nil {
                    startDownAnimation()
                } else {
                    if !downAnimator.isRunning {
                        downAnimator.startAnimation()
                    } else {
                        startDownAnimation()
                    }
                }
            }
        }
        
        btnPlayOrPause.isSelected = !btnPlayOrPause.isSelected
    }
    
    // MARK:- Other Methods
    private func startUpAnimation() {
        isAnimatingUpward = true
        constraintCenterYimgViewAngel.constant = (spacingTopAndBottom + (heightImgViewAngel / 2) - (heightScreen / 2))
        
        upAnimator = UIViewPropertyAnimator(duration: 5.0, curve: .easeInOut, animations: {
            self.view.layoutIfNeeded()
        })
        
        upAnimator.addCompletion { (thePosition) in
            self.startDownAnimation()
        }
        
        upAnimator.startAnimation()
    }
    
    private func startDownAnimation() {
        isAnimatingUpward = false
        constraintCenterYimgViewAngel.constant = -(spacingTopAndBottom + (heightImgViewAngel / 2) - (heightScreen / 2))
        
        downAnimator = UIViewPropertyAnimator(duration: 5.0, curve: .easeInOut) {
            self.view.layoutIfNeeded()
        }
        
        downAnimator.addCompletion { (thePosition) in
            self.startUpAnimation()
        }
        
        downAnimator.startAnimation()
    }
    
}

