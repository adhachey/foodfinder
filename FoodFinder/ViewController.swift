//
//  ViewController.swift
//  FoodFinder
//
//  Created by Hachey,Alex on 9/20/16.
//  Copyright © 2016 Hachey,Alex. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase
import SafariServices

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ref: FIRDatabaseReference!
    var storage = [AnyObject]()

    @IBOutlet weak var homeTableView: UITableView!
    
    
    @IBOutlet weak var myNo: UIImageView!
    @IBOutlet weak var myYes: UIImageView!
    @IBOutlet weak var myCard: UIImageView!
    @IBOutlet weak var myCardBorder: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTrayView: UIView!
    @IBOutlet weak var dynamicCounter: UILabel!
    
    @IBOutlet weak var testView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var initialNo: CGPoint!
    var initialYes: CGPoint!
    var initialCard: CGPoint!
    var initialCardBorder: CGPoint!
    var initialLabel: CGPoint!
    var initialTray: CGFloat!
    
    var initialTestView: CGFloat!
    
  

    
    var headerfavisHighLighted:Bool = false
    
    private var urlString:String = "https://google.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference().child("foodfinder")
        
      
        // Mark: CARD_SUBVIEW
        
        let testFrame : CGRect = CGRectMake(18,77,284,120)
        var testView : UIView = UIView(frame: testFrame)
        testView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        testView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha:
            1.0)
        testView.layer.borderWidth = 1
        testView.alpha=0.5
        testView.layer.borderColor = UIColor(red:211/255.0, green:211/255.0, blue:211/255.0, alpha: 1.0).CGColor
        self.view.addSubview(testView)
        
        var myField: UITextField = UITextField (frame:CGRectMake(0, 36, 284, 40));
        myField.text = "my text"
        myField.textAlignment = .Center
        myField.font = UIFont.systemFontOfSize(36)
        myField.alpha=0.5
        myField.transform = CGAffineTransformMakeScale(0.5, 0.5)
        testView.userInteractionEnabled = true;
        
        testView.addSubview(myField)

        UIView.animateWithDuration(0.3, animations: {
            testView.alpha=1
            testView.transform = CGAffineTransformMakeScale(1, 1)
            myField.alpha=1
            myField.transform = CGAffineTransformMakeScale(1, 1)
            
        })

        initialTray = myTrayView.frame.origin.y
        initialTestView = testView.frame.origin.y
    
    }
    
    
    // Mark: FIREBASE
    
    func didStartListening() {
        ref.observeEventType(.Value, withBlock: {(FIRDataSnapshot) in
            
            var tempstorage = [AnyObject]()
            
            for item in snapshot.children {
                let foodfinder = item as! FIRDataSnapshot
                var foodfinderinfo = [String:AnyObject]()
                if let recipetitle = foodfinder.value!["recipetitle"] as? String {
                    foodfinderinfo["recipetitle"] = recipetitle
                }
                if let recipesource = foodfinder.value!["recipesource"] as? String {
                    foodfinderinfo["recipesource"] = recipesource
                }
                if let recipeimage = foodfinder.value!["recipeimage"] as? String {
                    foodfinderinfo["recipeimage"] = recipeimage
                }
                let ref = foodfinder.ref
                foodfinderinfo["ref"] = ref
                
                tempstorage.append(foodfinderinfo)
            }
            
            self.storage = tempstorage
            self.homeTableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
          }
    
    
  // Mark: TABLEVIEW
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return storage.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: recipeTableViewCell = homeTableView.dequeueReusableCellWithIdentifier("recipeCell", forIndexPath: indexPath) as! recipeTableViewCell
        
        let foodobject = storage[indexPath.row]
        
        cell.recipetitle.text = fixObject["title"] as? String
       
        cell.recipeSource.text = "Recipe Source"
        
        cell.recipeTitle.text = "This is the title of the recipe"
        
        return cell
    }

    @IBAction func openWebVIew(sender: UIButton) {
        let svc = SFSafariViewController(URL: NSURL(string: self.urlString)!)
        self.presentViewController(svc, animated: true, completion: nil)
        
    

    }


    
    @IBAction func headerFav(sender: UIButton) {
         performSegueWithIdentifier("favorites", sender: nil)
//        if headerfavisHighLighted == false{
//            sender.selected = true;
//            headerfavisHighLighted = true
//          
//
//       
//        }
//        else{
//            sender.selected = false;
//            headerfavisHighLighted = false
//        }
    }

// Mark: CARD_SWIPE

    @IBAction func didPanTray(sender: UIPanGestureRecognizer) {
    let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {

            initialNo = myNo.center
            initialYes = myYes.center
            initialCard = myCard.center
            initialCardBorder = myCardBorder.center
            initialLabel = myLabel.center
            myNo.alpha = 0
            myYes.alpha = 0
            self.myCardBorder.alpha = 0
            self.myCardBorder.layer.borderWidth = 2

            self.myCardBorder.layer.borderColor = UIColor(red:211/255.0, green:211/255.0, blue:211/255.0, alpha: 1.0).CGColor
        }
        
        else if sender.state == UIGestureRecognizerState.Changed {

            print("\(translation.x)")
            
            myNo.center = CGPoint(x: initialNo.x + translation.x, y: initialNo.y)
            myYes.center = CGPoint(x: initialYes.x + translation.x, y: initialYes.y)
            myCard.center = CGPoint(x: initialCard.x + translation.x, y: initialCard.y)
            myCardBorder.center = CGPoint(x: initialCardBorder.x + translation.x, y: initialCardBorder.y)
            myLabel.center = CGPoint(x: initialLabel.x + translation.x, y: initialLabel.y)
            
            
            if translation.x < -100 {
                UIView.animateWithDuration(0.3, animations: {
                    self.myCardBorder.layer.borderColor = UIColor(red:194/255.0, green:33/255.0, blue:0/255.0, alpha: 1.0).CGColor
                    self.myCardBorder.alpha = 1

                    
                    self.myNo.alpha = 1
                    self.myYes.alpha = 0
                    
                    
                })

            }
            else if translation.x > 100 {
                UIView.animateWithDuration(0.3, animations: { 
                    self.myCardBorder.layer.borderColor = UIColor(red:186/255.0, green:208/255.0, blue:0/255.0, alpha: 1.0).CGColor
                    self.myCardBorder.alpha = 1
                    
                    
                    self.myNo.alpha = 0
                    self.myYes.alpha = 1

                })
            }
            else if translation.x > -100 && translation.x < 100 {
                
                UIView.animateWithDuration(0.3, animations: {
                
                    self.myCardBorder.alpha = 0
                    self.myNo.alpha = 0
                    self.myYes.alpha = 0
        
                })}}
                
                
        
        else if sender.state == UIGestureRecognizerState.Ended {
            
                
            if translation.x > -100 && translation.x < 100 {
            
                UIView.animateWithDuration(0.3, animations: {
                    self.myYes.center = self.initialYes
                    self.myNo.center = self.initialNo
                    self.myCard.center = self.initialCard
                    self.myCardBorder.center = self.initialCardBorder
                    self.myLabel.center = self.initialLabel
                    
                    
                    self.myCardBorder.alpha = 0
                    self.myCardBorder.layer.borderWidth = 0
                    self.myCardBorder.layer.borderColor = UIColor.grayColor().CGColor
                    self.myNo.alpha = 0
                    self.myYes.alpha = 0
                    
                })}
            else if translation.x < -100 {
                UIView.animateWithDuration(0.3, animations: {
                    self.myNo.center = CGPoint(x: self.initialNo.x - 400, y: self.initialNo.y)
                    self.myYes.center = CGPoint(x: self.initialYes.x - 400, y: self.initialYes.y)
                    self.myCard.center = CGPoint(x: self.initialCard.x - 400, y: self.self.initialCard.y)
                    self.myCardBorder.center = CGPoint(x: self.initialCardBorder.x - 400, y: self.initialCardBorder.y)
                    self.myLabel.center = CGPoint(x: self.initialLabel.x - 400, y: self.initialLabel.y)
                })
                
            }
            else if translation.x > 100 {
                UIView.animateWithDuration(0.3, animations: {
                    self.myNo.center = CGPoint(x: self.initialNo.x + 400, y: self.initialNo.y)
                    self.myYes.center = CGPoint(x: self.initialYes.x + 400, y: self.initialYes.y)
                    self.myCard.center = CGPoint(x: self.initialCard.x + 400, y: self.self.initialCard.y)
                    self.myCardBorder.center = CGPoint(x: self.initialCardBorder.x + 400, y: self.initialCardBorder.y)
                    self.myLabel.center = CGPoint(x: self.initialLabel.x + 400, y: self.initialLabel.y)
                    self.dynamicCounter.text = "300 recipes"
                    
                //make funciton somewhere else
                    // funcname create subtview week3 lab
                })}}
        
        
        
        
        
    }}