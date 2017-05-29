//
//  ParkingInterval.swift
//  Viale
//
//  Created by Kai Nakamura on 5/29/17.
//  Copyright © 2017 Kai Nakamura. All rights reserved.
//

import Foundation
import UIKit

class ParkingInterval {
    
    var startDate : Date?
    var endDate : Date?
    var ratePerHour : Float?
    var rules : String?
    var availableSlots : Int?
    var totalSlots: Int?
    
    init(startNumber:Double,endNumber:Double,ratePerHour:Float,rules:String,availableSlots:Int,totalSlots:Int) {
        
        //Convert the floats into dates
        
        self.startDate = Date(timeIntervalSince1970: startNumber)
        self.endDate = Date(timeIntervalSince1970: endNumber)
        
        self.ratePerHour = ratePerHour
        self.rules = rules
        self.availableSlots = availableSlots
        self.totalSlots = totalSlots
        
    }
    
    
}
