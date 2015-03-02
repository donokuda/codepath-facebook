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
    @IBOutlet weak var photosScrollView: UIScrollView!
    
    var photoImage: UIImage!
    var dismissing: Bool = false
    var scrollViewIsZooming: Bool {
        get {
            return photosScrollView.zoomScale > 1.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = photoImage
        photoImageView.frame = imageViewFrameForImage(photoImageView.image!, inView: photoImageView.superview!)
        photosScrollView.contentSize = photoImageView.frame.size
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if dismissing || scrollViewIsZooming {
            return
        }
        
        var alpha = 1 - abs(scrollView.contentOffset.y) / scrollView.bounds.height
        dimmingView.alpha = alpha
        doneButton.alpha = alpha
        photoActionsImageView.alpha = alpha
    }

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollViewIsZooming {
            return
        }
        
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
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func imageViewFrameForImage(image: UIImage, inView view: UIView) -> CGRect {
        let fromImageSize = image.size
        var aspectRatio: CGFloat = CGFloat(fromImageSize.height / fromImageSize.width)
        var toViewBounds = view.bounds
        var toImageViewWidth = CGRectGetWidth(toViewBounds)
        var toImageViewHeight = toImageViewWidth * aspectRatio
        
        return CGRect(x: 0, y: CGRectGetMidY(toViewBounds) - toImageViewHeight * 0.5, width: toImageViewWidth, height: toImageViewHeight)
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        var scrollViewSize = scrollView.bounds.size
        var imageViewSize = photoImageView.frame.size
        
        if imageViewSize.width < scrollViewSize.width {
           photoImageView.frame.origin.x = (scrollViewSize.width - imageViewSize.width) / 2
        } else {
           photoImageView.frame.origin.x = 0
        }
        
        if imageViewSize.height < scrollViewSize.height {
           photoImageView.frame.origin.y = (scrollViewSize.height - imageViewSize.height) / 2
        } else {
           photoImageView.frame.origin.y = 0
        }
    }
}