//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Don Okuda on 2/27/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dimmingView: UIView!
    @IBOutlet weak var photoActionsImageView: UIImageView!
    
    var photoImage: UIImage!
    var dismissing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = photoImage
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if !dismissing {
            var alpha = 1 - abs(scrollView.contentOffset.y) / scrollView.bounds.height
            dimmingView.alpha = alpha
            doneButton.alpha = alpha
            photoActionsImageView.alpha = alpha
        }
    }

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if abs(scrollView.contentOffset.y) >= 100 {
            dismiss()
        }
    }
    
    @IBAction func didTapDone(sender: AnyObject) {
        dismiss()
    }
    
    func dismiss() {
        dismissing = true
        
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.dismissing = false
        })
    }
}
