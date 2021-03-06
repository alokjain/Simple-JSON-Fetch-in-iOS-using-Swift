//
//  DetailViewController.swift
//  Honest Reviews
//
//  Created by Arjun on 15/11/14.
//  Copyright (c) 2014 Techulus. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var Photo: UIImageView!
    var imageCache = [String : UIImage]()
    
    var detailItem: Post? {
        didSet {
            self.title = detailItem?.title
            self.configureView()
            self.setPhoto()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Post = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detailItem?.title
            }
        }
    }
    
    func setPhoto() {
        var image = self.imageCache["thumb"]
        
        if( image == nil ) {
            // If the image does not exist, we need to download it
            var imgURL: NSURL? = NSURL(string: "http://findmyboat.in/upload/uploads/\(self.detailItem!.image)")
            
            // Download an NSData representation of the image at the URL
            let request: NSURLRequest = NSURLRequest(URL: imgURL!)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    image = UIImage(data: data)
                    
                    // Store the image in to our cache
                    self.imageCache["thumb"] = image
                    dispatch_async(dispatch_get_main_queue(), {
                        self.Photo.image = image
                    })
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                self.Photo.image = image
            })
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColorFromRGB(0x99CCFF)
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

