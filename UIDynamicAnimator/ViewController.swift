//
//  ViewController.swift
//  UIDynamicAnimator
//
//  Created by Александр Карпов on 06.01.2023.
//

import UIKit

//UICollisionBehavior - обнаружения столкновений
//UIGravityBehavior - обеспечение тяготения (граитация)
//UIPushBehavior - реагирует на толчки
//UISnapBehavior - крепит view к определенной точке

class ViewController: UIViewController {
    
    let squareView = UIView()
    var animator = UIDynamicAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // create square
        
        squareView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        squareView.backgroundColor = .green
        squareView.center = view.center
        view.addSubview(squareView)
        
        // create animator and gravity
        
        animator = UIDynamicAnimator(referenceView: view)
        let gravity = UIGravityBehavior(items: [squareView])
        animator.addBehavior(gravity)
        
    }
    
    

}

