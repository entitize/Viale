//
//  ManageDrivewayVC.swift
//  Viale
//
//  Created by Kai Nakamura on 5/27/17.
//  Copyright © 2017 Kai Nakamura. All rights reserved.
//

import Foundation
import UIKit
import PKHUD
import Firebase

class ManageDrivewayVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let kCloseCellHeight: CGFloat = 86
    let kOpenCellHeight: CGFloat = 190
    
    var numberOfIntervals = 0
    
    var cellHeights = [CGFloat]()
    var intervalKeys = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        //Clear any existing data
        intervalKeys = []
        
        //Download the data
        HUD.show(.progress)
        
        numberOfIntervals = 0
        
        DataService.ds.REF_USER_PARKINGS.child("intervals").observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                self.intervalKeys = []
                
                for snap in snapshot {
                    if let isActive = snap.value as? Bool {
                        let key = snap.key
                        if (isActive) {
                            //Getting the keys of the 'parkings'
                            
                            self.intervalKeys.append(key)
                        }
                    }
                    self.numberOfIntervals += 1
                }
                HUD.hide()
            }
            
            //Setup cellHeights array
            self.createCellHeightsArray()
            
            self.tableView.reloadData()
            
            
        }) { (error) in
            HUD.flash(.labeledError(title: "Error", subtitle: "There was an error with Keanu"), delay: 2.5)
        }
        
        
        
    }
    
    func createCellHeightsArray() {
        for _ in 0...numberOfIntervals {
            cellHeights.append(kCloseCellHeight)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as IntervalCell = cell else {
            return
        }
        
        cell.backgroundColor = UIColor.clear
        
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeights[(indexPath as NSIndexPath).row]
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IntervalCell", for: indexPath) as! IntervalCell
        
        //Now assign to each cell the intervalKeys and then activate the setup function
        let intervalKey = intervalKeys[indexPath.row]
        cell.setupIntervalListener(intervalKey: intervalKey)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intervalKeys.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! IntervalCell
        if cell.isAnimating() {
            return
        }
        var duration = 0.0
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight { // open cell
            cellHeights[(indexPath as NSIndexPath).row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[(indexPath as NSIndexPath).row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    
    
    
    @IBAction func saveAndExitTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
