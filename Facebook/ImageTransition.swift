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

        photoViewController.photoImageView.hidden = true
        
        let selectedImageView = newsFeedViewController.selectedImageView
        let animatedImageView = UIImageView(image: selectedImageView.image)
        animatedImageView.contentMode = .ScaleAspectFit
        
        let window = selectedImageView.window
        
        animatedImageView.frame = window!.convertRect(selectedImageView.frame, fromView: newsFeedViewController.scrollView)
        
        selectedImageView.window?.addSubview(animatedImageView)
       
        toViewController.view.alpha = 0
        UIView.animateWithDuration(duration, animations: {
            
            animatedImageView.frame = window!.convertRect(photoViewController.photoImageView.frame, fromView: photoViewController.view)
            
            toViewController.view.alpha = 1
            }) { (finished: Bool) -> Void in
                animatedImageView.removeFromSuperview()
                photoViewController.photoImageView.hidden = false
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
        let window = fromImageView.window
        let toImageView = newsFeedViewController.selectedImageView
        
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
