//
//  FifthViewController.swift
//  UIDynamicAnimator
//
//  Created by Александр Карпов on 09.01.2023.
//

import UIKit

class FifthViewController: UIViewController {
    
    // UIAttachmentBehavior
    // UISnapBehavior
    
    var squareView = UIView()
    var animator = UIDynamicAnimator()
    var snapBehavior: UISnapBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "fifthVC"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        createGestureRecognizer()
        createSmallSquareView()
        createAnimatorAndBehaviors()
    }
    
    func createGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(paramTap:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func createSmallSquareView() {
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        squareView.center = view.center
        squareView.backgroundColor = .green
        view.addSubview(squareView)
    }

    func createAnimatorAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        // Snap
        
        snapBehavior = UISnapBehavior(item: squareView, snapTo: squareView.center)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
        
    }


    @objc func handleTap(paramTap: UITapGestureRecognizer) {
        let tapPoint = paramTap.location(in: view)
        if snapBehavior != nil {
            animator.removeBehavior(snapBehavior!)
            
        }
        snapBehavior = UISnapBehavior(item: squareView, snapTo: tapPoint)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
        
        
    }
    
}
