//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Don Okuda on 2/27/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = photoImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTapDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
