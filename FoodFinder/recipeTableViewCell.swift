//
//  recipeTableViewCell.swift
//  FoodFinder
//
//  Created by Hachey,Alex on 9/22/16.
//  Copyright © 2016 Hachey,Alex. All rights reserved.
//

import UIKit

class recipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    
var favisHighLighted:Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func recipeFav(sender: UIButton) {
        if favisHighLighted == false{
            sender.selected = true;
            favisHighLighted = true
        }
        else{
            sender.selected = false;
            favisHighLighted = false
        }}
        }

