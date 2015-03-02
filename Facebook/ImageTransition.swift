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
        toImageView.hidden = true
        toImageView.frame = imageViewFrameForImage(fromImageView.image!, inView: toImageView.superview!)
       
        toViewController.view.alpha = 0
        
        transitionFromImageView(fromImageView, toImageView: toImageView, animations: { () -> () in
            toViewController.view.alpha = 1
        }) { (completed) -> () in
            toImageView.hidden = false
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let tabBarController = toViewController as UITabBarController
        let viewControllers = tabBarController.viewControllers as [UIViewController]
        let navigationController = viewControllers[0] as UINavigationController
        let newsFeedViewController = navigationController.topViewController as NewsFeedViewController
        let photoViewController = fromViewController as PhotoViewController
        
        let fromImageView = photoViewController.photoImageView
        fromImageView.hidden = true
        
        let toImageView = newsFeedViewController.selectedImageView
        
        transitionFromImageView(fromImageView, toImageView: toImageView, animations: { () -> () in
            fromViewController.view.alpha = 0
            
            }) { (completed) -> () in
        }
    }
    
    func imageViewFrameForImage(image: UIImage, inView view: UIView) -> CGRect {
        let fromImageSize = image.size
        var aspectRatio: CGFloat = CGFloat(fromImageSize.height / fromImageSize.width)
        var toViewBounds = view.bounds
        var toImageViewWidth = CGRectGetWidth(toViewBounds)
        var toImageViewHeight = toImageViewWidth * aspectRatio
        
        return CGRect(x: 0, y: CGRectGetMidY(toViewBounds) - toImageViewHeight * 0.5, width: toImageViewWidth, height: toImageViewHeight)
    }
    
    func transitionFromImageView(fromImageView: UIImageView, toImageView: UIImageView, animations: () -> (), completion: (Bool) -> ()) {
        let window = fromImageView.window
        
        let transitionImageView = UIImageView(image: fromImageView.image)
        transitionImageView.contentMode = toImageView.contentMode
        transitionImageView.clipsToBounds = true
        transitionImageView.frame = window!.convertRect(fromImageView.frame, fromView: fromImageView.superview)
        window?.addSubview(transitionImageView)
        
        UIView.animateWithDuration(duration, animations: {
            transitionImageView.frame = window!.convertRect(toImageView.frame, fromView: toImageView.superview)
            animations()
        }) { (finished: Bool) -> Void in
            transitionImageView.removeFromSuperview()
            completion(finished)
            self.finish()
        }
    }
}
