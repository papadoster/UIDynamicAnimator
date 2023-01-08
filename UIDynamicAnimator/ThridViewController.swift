//
//  ThridViewController.swift
//  UIDynamicAnimator
//
//  Created by Александр Карпов on 06.01.2023.
//

import UIKit

class ThridViewController: UIViewController {

    
    var squareViews = UIView()
    var animator = UIDynamicAnimator()
    var pushBehavior = UIPushBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        createGestureRecognazer()
        createSmallSquareView()
        createAnimationAndBehavior()
         
    }
    
    //create square

    func createSmallSquareView() {
        squareViews = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        squareViews.backgroundColor = .orange
        squareViews.center = view.center
        view.addSubview(squareViews)
    }
    
    //create Gesture
    
    func createGestureRecognazer() {
        let tapGestureRecognazer = UITapGestureRecognizer(target: self, action: #selector(hendleTap(paramTap:)))
        view.addGestureRecognizer(tapGestureRecognazer)
    }
    
    // создаем столкновения и толчок у View
    
    func createAnimationAndBehavior() {
        animator = UIDynamicAnimator(referenceView: view)
        
        // create collision
        
        let collision = UICollisionBehavior(items: [squareViews])
        collision.translatesReferenceBoundsIntoBoundary = true
        pushBehavior = UIPushBehavior(items: [squareViews], mode: .continuous)
        animator.addBehavior(collision)
        animator.addBehavior(pushBehavior)
    }
    
    
    @objc func hendleTap(paramTap: UITapGestureRecognizer) {
         // recive corner view
        
//        print("tap")
        let tapPoint: CGPoint = paramTap.location(in: view)
        let squareViewCenterPoint: CGPoint = squareViews.center
        // arc tangent 2((p1.x - p2.x), (p1.y - p2.y))
        
        let deltaX: CGFloat = tapPoint.x - squareViewCenterPoint.x
        let deltaY: CGFloat = tapPoint.y - squareViewCenterPoint.y
        let angle: CGFloat = atan2(deltaY, deltaX)
        pushBehavior.angle = angle
        
        let distanceBetweenPoints: CGFloat = sqrt(pow(tapPoint.x - squareViewCenterPoint.x, 2.0) + pow(tapPoint.y - squareViewCenterPoint.y, 2.0))
        
        pushBehavior.magnitude = distanceBetweenPoints / 100
        
    }
    
    
}
