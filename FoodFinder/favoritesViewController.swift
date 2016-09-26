//
//  favoritesViewController.swift
//  FoodFinder
//
//  Created by Hachey,Alex on 9/22/16.
//  Copyright © 2016 Hachey,Alex. All rights reserved.
//

import UIKit

class favoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var favoritesTableView: UITableView!
    
    var headerfavisHighLighted:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func backtomain(sender: UIButton) {
        self.dismissViewControllerAnimated(true){}
        print("dismiss")
        
        
        
//        if headerfavisHighLighted == false{
//            sender.aselected = true;
//            headerfavisHighLighted = true
//            
//            
//        }
//        else{
//            headerfavisHighLighted = true
//            sender.selected = false;
//    
//        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = favoritesTableView.dequeueReusableCellWithIdentifier("favrecipeCell", forIndexPath: indexPath) as! favrecipeTableViewCell
        
        cell.favRecipeSource.text = "Recipe Source"
        
        cell.favRecipeTitle.text = "This is the title of the recipe"
        
        return cell
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
