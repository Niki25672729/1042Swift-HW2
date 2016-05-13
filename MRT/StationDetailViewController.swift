//
//  StationDetailViewController.swift
//  MRT
//
//  Created by Niki25672729 on 5/13/16.
//  Copyright © 2016 Niki. All rights reserved.
//

import UIKit

class StationDetailViewController: UIViewController {

    @IBOutlet weak var StationNameLabel: UILabel!
    @IBOutlet weak var LineNameLabelL: UILabel!
    @IBOutlet weak var LineNameLabelR: UILabel!
    @IBOutlet weak var LineNameLabelM: UILabel!
    @IBOutlet weak var ViewNavgationTitle: UINavigationItem!
    
    var station: Station! {
        didSet {
            self.updateValues()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateValues()
    }
    
    func updateValues() {
        guard self.isViewLoaded() else {
            return
        }
        
        self.StationNameLabel.text = station!.name
        self.ViewNavgationTitle.title = station!.name
        
        if station!.lines!.count > 1{
            self.LineNameLabelM.hidden = true
            (self.LineNameLabelL.text!, _) = station!.lines!.first!
            (self.LineNameLabelR.text!, _) = station!.lines!.reverse().first!
            LabelColor(self.LineNameLabelL!.text!, CellLabel: self.LineNameLabelL)
            LabelColor(self.LineNameLabelR!.text!, CellLabel: self.LineNameLabelR)
        }
        else {
            self.LineNameLabelL.hidden = true
            self.LineNameLabelR.hidden = true
            (self.LineNameLabelM!.text!, _) = station!.lines!.first!
            LabelColor(self.LineNameLabelM!.text!, CellLabel: self.LineNameLabelM)
        }
    }
    
    
    func LabelColor(LabelName: String, CellLabel: UILabel) -> Void {
        switch LabelName {
        case "文湖線":
            CellLabel.backgroundColor = UIColor(red: 158/255.0, green: 101/255.0, blue: 46/255.0, alpha: 1)
        case "淡水信義線":
            CellLabel.backgroundColor = UIColor(red: 203/255.0, green: 44/255.0, blue: 48/255.0, alpha: 1)
        case "新北投支線":
            CellLabel.backgroundColor = UIColor(red: 248/255.0, green: 144/255.0, blue: 165/255.0, alpha: 1)
        case "松山新店線":
            CellLabel.backgroundColor = UIColor(red: 0/255.0, green: 119/255.0, blue: 73/255.0, alpha: 1)
        case "小碧潭支線":
            CellLabel.backgroundColor = UIColor(red: 206/255.0, green: 220/255.0, blue: 0/255.0, alpha: 1)
        case "中和新蘆線":
            CellLabel.backgroundColor = UIColor(red: 255/255.0, green: 163/255.0, blue: 0/255.0, alpha: 1)
        case "板南線":
            CellLabel.backgroundColor = UIColor(red: 0/255.0, green: 94/255.0, blue: 184/255.0, alpha: 1)
        case "貓空纜車":
            CellLabel.backgroundColor = UIColor(red: 119/255.0, green: 185/255.0, blue: 51/255.0, alpha: 1)
        default:
            break
        }
        
    }


}
