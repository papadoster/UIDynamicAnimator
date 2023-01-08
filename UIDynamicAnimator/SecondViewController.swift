//
//  SecondViewController.swift
//  UIDynamicAnimator
//
//  Created by Александр Карпов on 06.01.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    var squareViews = [UIDynamicItem]()
    var animator = UIDynamicAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // create view
        let numberOfView = 2
        squareViews.reserveCapacity(numberOfView)
        let colors = [UIColor.green, UIColor.red]
//        let colors = UIColor.black
        var currentCenterPoint = CGPoint(x: view.center.x, y: 0)
        let eachViewSize = CGSize(width: 50, height: 50)
        
        for counter in 0..<numberOfView {
            let newView = UIView(frame: CGRect(x: 0, y: 0, width: eachViewSize.width, height: eachViewSize.height))
            newView.backgroundColor = colors[counter]
//            newView.backgroundColor = colors
            newView.center = currentCenterPoint
            currentCenterPoint.y += eachViewSize.height + 30
            view.addSubview(newView)
            squareViews.append(newView)
        }
        
        animator = UIDynamicAnimator(referenceView: view)
        
        // create gravity
        let gravity = UIGravityBehavior(items: squareViews)
        animator.addBehavior(gravity)
        
        //create push
        
        let collision = UICollisionBehavior(items: squareViews)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        collision.addBoundary(withIdentifier: "bottomBoundary" as NSCopying,
                              from: CGPoint(x: 0, y: view.bounds.size.height - 100),
                              to: CGPoint(x: view.bounds.size.width, y: view.bounds.size.height))
        
        collision.collisionDelegate = self
        animator.addBehavior(collision)
         
        
        
    }
    
    

}

extension SecondViewController: UICollisionBehaviorDelegate {
    
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        let identifier = identifier as? String
        let kbottomBoundary = "bottomBoundary"
        
        if identifier == kbottomBoundary {
            
            UIView.animate(withDuration: 2.0) {
                let view = item as? UIView
                view?.backgroundColor = .orange
                view?.alpha = 0.0
                view?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            } completion: { finished in
                let view = item as? UIView
                behavior.removeItem(item)
                view?.removeFromSuperview()
            }
        }
         
    }
}
