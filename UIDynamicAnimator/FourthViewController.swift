//
//  FourthViewController.swift
//  UIDynamicAnimator
//
//  Created by Александр Карпов on 08.01.2023.
//

import UIKit

class FourthViewController: UIViewController {

    // UIAttachmentBehavior
    // UISnapBehavior
    
    var squareView = UIView()
    var squareViewAnchorView = UIView()
    var anchorView = UIView()
    var animator = UIDynamicAnimator()
    var attachmentBehavior: UIAttachmentBehavior?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "fourthVC"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        createGestureRecognizer()
        createSmallSquareView()
        createAnchorView()
        createAnimationAndBehaviors()
    }
    
    // create square
    
    func createSmallSquareView() {
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        squareView.backgroundColor = .green
        squareView.center = view.center
        squareViewAnchorView = UIView(frame: CGRect(x: 60, y: 0, width: 20, height: 20))
        squareViewAnchorView.backgroundColor = .green
        squareView.addSubview(squareViewAnchorView)
        view.addSubview(squareView)
    }
    
    // create view с точкой привязки
    
    func createAnchorView() {
        
        anchorView = UIView(frame: CGRect(x: squareView.center.x + 80, y: squareView.center.y + 80, width: 20, height: 20))
        anchorView.backgroundColor = .white
        view.addSubview(anchorView)
    }
    
    // create a pan gesture recorder
    
    func createGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(paramPan:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }

    // create collision and Attachment
    
    func createAnimationAndBehaviors() {
         animator = UIDynamicAnimator(referenceView: view)
        
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        attachmentBehavior = UIAttachmentBehavior(item: squareView, attachedToAnchor: anchorView.center)
        animator.addBehavior(collision)
        animator.addBehavior(attachmentBehavior!)
        
    }
    
    // определяет где палец, туда красный квадрат, а потом привязка к большому квадрату
    
    @objc func handlePan(paramPan: UIPanGestureRecognizer) {
        let tapPoint = paramPan.location(in: view)
        print(tapPoint)
        attachmentBehavior?.anchorPoint = tapPoint
        anchorView.center = tapPoint
        
    }
    
}

