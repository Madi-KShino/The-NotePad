//
//  CustomSegues.swift
//  Today
//
//  Created by Madison Kaori Shino on 8/1/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class CustomSegues: UIStoryboardSegue {
    
    override func perform() {
        scale()
    }
    
    func scale() {
        let toViewController = self.destination
        let fromViewController = self.source
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter
        containerView?.addSubview(toViewController.view)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { (success) in
            fromViewController.present(toViewController, animated: false, completion: nil)
        })
    }
}

class UnwindCusomSegue: UIStoryboardSegue {
    
    override func perform() {
        scale()
    }
    
    func scale() {
        let toViewController = self.destination
        let fromViewController = self.source
        fromViewController.view.superview?.insertSubview(toViewController.view, at: 0)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            fromViewController.view.transform = CGAffineTransform.identity
        }, completion: { (success) in
            fromViewController.dismiss(animated: false, completion: nil)
        })
    }
}

/*
In view controller add
 ibaction func prepareForUnwind (segue: UiStoryboardSegue) {
}

 override func unwind(for unwindSegue: UIStoryboardSegue, subsequentVC: UIViewController) {
 let segue = UnwindSegue(identifier: inwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
 segue.perform()
 }
 */

