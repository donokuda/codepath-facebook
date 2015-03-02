//
//  ImageTransition.swift
//  Facebook
//
//  Created by Don Okuda on 3/1/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        
        let tabBarController = fromViewController as UITabBarController
        let viewControllers = tabBarController.viewControllers as [UIViewController]
        let navigationController = viewControllers[0] as UINavigationController
        let newsFeedViewController = navigationController.topViewController as NewsFeedViewController
        let photoViewController = toViewController as PhotoViewController

        let fromImageView = newsFeedViewController.selectedImageView
        let toImageView = photoViewController.photoImageView
        let window = fromImageView.window
        
        let transitionImageView = UIImageView(image: fromImageView.image)
        transitionImageView.contentMode = .ScaleAspectFit
        transitionImageView.frame = window!.convertRect(fromImageView.frame, fromView: fromImageView.superview)
        window?.addSubview(transitionImageView)
       
        toViewController.view.alpha = 0
        toImageView.hidden = true
        
        UIView.animateWithDuration(duration, animations: {
            transitionImageView.frame = window!.convertRect(toImageView.frame, fromView: toImageView.superview)
            toViewController.view.alpha = 1
        }) { (finished: Bool) -> Void in
            transitionImageView.removeFromSuperview()
            toImageView.hidden = false
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let tabBarController = toViewController as UITabBarController
        let viewControllers = tabBarController.viewControllers as [UIViewController]
        let navigationController = viewControllers[0] as UINavigationController
        let newsFeedViewController = navigationController.topViewController as NewsFeedViewController
        let photoViewController = fromViewController as PhotoViewController
        
        let fromImageView = photoViewController.photoImageView
        let toImageView = newsFeedViewController.selectedImageView
        let window = fromImageView.window
        
        var transitionImageView = UIImageView(image: fromImageView.image)
        transitionImageView.contentMode = fromImageView.contentMode
        transitionImageView.frame = window!.convertRect(fromImageView.frame, fromView: fromImageView.superview)
        window?.addSubview(transitionImageView)
        
        fromImageView.hidden = true
        
        UIView.animateWithDuration(duration, animations: {
            transitionImageView.frame = window!.convertRect(toImageView.frame, fromView: toImageView.superview)
            fromViewController.view.alpha = 0
        }) { (finished: Bool) -> Void in
            transitionImageView.removeFromSuperview()
            self.finish()
        }
    }
}
