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
    @IBOutlet weak var dimmingView: UIView!
    @IBOutlet weak var photoActionsImageView: UIImageView!
    @IBOutlet weak var photosScrollView: UIScrollView!

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!

    var photoImageView: UIImageView {
        get {
            return self.images[self.startPage]
        }
    }

    lazy var images: [UIImageView] = self.allImages()

    func allImages() -> [UIImageView] {
        return [imageView1, imageView2, imageView3, imageView4, imageView5]
    }

    var photoImage: UIImage!
    var dismissing: Bool = false
    var scrollViewIsZooming: Bool {
        get {
            return photosScrollView.zoomScale > 1.0
        }
    }

    var startPage = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Fade)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for (index, imageView) in enumerate(images) {
            imageView.frame = frameForImageView(imageView, atPage: index)
        }

        photosScrollView.contentSize = photosScrollView.bounds.size
        photosScrollView.contentSize.width *= 5

        var startOffset = CGPoint(x: photosScrollView.bounds.size.width * CGFloat(startPage), y: 0)

        photosScrollView.setContentOffset(startOffset, animated: false)
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
        if scrollView == photosScrollView {
            return nil
        }

        return photoImageView
    }

    func frameForImageView(imageView: UIImageView, atPage page: Int) -> CGRect {
        let fromImageSize = imageView.image!.size
        var aspectRatio: CGFloat = CGFloat(fromImageSize.height / fromImageSize.width)
        var toViewBounds = photosScrollView.bounds
        var toImageViewWidth = CGRectGetWidth(toViewBounds)
        var toImageViewHeight = toImageViewWidth * aspectRatio
        
        return CGRect(x: 0, y: CGRectGetMidY(toViewBounds) - toImageViewHeight * 0.5, width: toImageViewWidth, height: toImageViewHeight)
    }
    
    @IBAction func didDoubleTapPhoto(sender: UITapGestureRecognizer) {
        var zoomScale = scrollViewIsZooming ? photosScrollView.minimumZoomScale : photosScrollView.maximumZoomScale
        photosScrollView.setZoomScale(zoomScale, animated: true)
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        var scrollViewSize = scrollView.bounds.size
        var imageView = scrollView.subviews[0] as UIImageView
        var imageViewSize = imageView.frame.size

        if imageViewSize.width < scrollViewSize.width {
           imageView.frame.origin.x = (scrollViewSize.width - imageViewSize.width) / 2
        } else {
            imageView.frame.origin.x = 0
        }
        
        if imageViewSize.height < scrollViewSize.height {
           imageView.frame.origin.y = (scrollViewSize.height - imageViewSize.height) / 2
        } else {
           imageView.frame.origin.y = 0
        }
    }
}