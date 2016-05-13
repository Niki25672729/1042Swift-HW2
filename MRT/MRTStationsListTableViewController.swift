//
//  MRTStationsListTableViewController.swift
//  MRT
//
//  Created by Ｎiki25672729 on 5/3/16.
//  Copyright © 2016 Niki. All rights reserved.
//

import UIKit

class MRTStationsListTableViewController: UITableViewController {
    
    var MRTStationsData: MRTStationSource!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataPath = NSBundle.mainBundle().pathForResource("MRT", ofType: "json")!
        guard let MRTStationsSource = try? MRTStationSource(contentsOfFile: dataPath) else {
            fatalError()
        }
        self.MRTStationsData = MRTStationsSource
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.MRTStationsData.lines.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.MRTStationsData.lines[section].stations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StationCell", forIndexPath: indexPath) as! MyTableViewCell
        let station = self.MRTStationsData.lines[indexPath.section].stations[indexPath.row]
        cell.TitleLabel!.text = station.name
        if station.lines!.count > 1 {
            for stationName in station.lines!.keys {
                if stationName == self.MRTStationsData.lines[indexPath.section].name {
                    cell.LineNumberLabelL!.text = station.lines![stationName]
                    cell.LineNumberLabelL.hidden = false
                    LabelColor(stationName, CellLabel: cell.LineNumberLabelL)
                }
                else {
                    cell.LineNumberLabelR!.text = station.lines![stationName]
                    LabelColor(stationName, CellLabel: cell.LineNumberLabelR)
                }
            }
        }
        else {
            cell.LineNumberLabelR!.text = station.lines![self.MRTStationsData.lines[indexPath.section].name!]
            LabelColor(self.MRTStationsData.lines[indexPath.section].name!, CellLabel: cell.LineNumberLabelR)
            cell.LineNumberLabelL.hidden = true
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.MRTStationsData.lines[section].name
    }

    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let segueIdentifier = segue.identifier else {
            return
        }
        
        if segueIdentifier == "ShowDetail" {
            guard let detailViewController = segue.destinationViewController as? StationDetailViewController else {
                return
            }
            guard let cell = sender as? UITableViewCell else { return }
            let indexPath = self.tableView.indexPathForCell(cell)!
            let station = self.MRTStationsData.lines[indexPath.section].stations[indexPath.row]
            detailViewController.station = station
        }
    }

}
