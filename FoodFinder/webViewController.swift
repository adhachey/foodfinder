//
//  webViewController.swift
//  FoodFinder
//
//  Created by Hachey,Alex on 9/23/16.
//  Copyright © 2016 Hachey,Alex. All rights reserved.
//

import UIKit
import SafariServices

class webViewController: UIViewController {
    private var urlString:String = "https://google.com"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let svc = SFSafariViewController(URL: NSURL(string: self.urlString)!)
        self.presentViewController(svc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
