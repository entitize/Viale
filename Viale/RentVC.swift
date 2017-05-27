//
//  RentVC.swift
//  Viale
//
//  Created by Kai Nakamura on 5/27/17.
//  Copyright © 2017 Kai Nakamura. All rights reserved.
//

import UIKit
import DateTimePicker

class RentVC: UIViewController {
    override func viewDidLoad() {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        let picker = DateTimePicker.show(minimumDate: min, maximumDate: max)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "!! DONE DONE !!"
        picker.todayButtonTitle = "Today"
        picker.is12HourFormat = true
        picker.dateFormat = "hh:mm aa dd/MM/YYYY"
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
            print(formatter.string(from: date))
        }
    }
}
