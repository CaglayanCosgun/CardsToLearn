//
//  Statistic.swift
//  CardsToLearn
//
//  Created by Cagla Yan on 07.06.23.
//

import SwiftUI

struct Statistic: Identifiable {
    var id = UUID().uuidString
    var hour: Date
    var views: Double
    var animate: Bool = false
}

extension Date{
    
    func updateHour(value: Int)->Date{
        
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}

var sample_analytics: [Statistic] = [

    Statistic(hour: Date().updateHour(value: 8), views: 1000),
    Statistic(hour: Date().updateHour(value: 9), views: 12000),
    Statistic(hour: Date().updateHour(value: 10), views: 3000),
    Statistic(hour: Date().updateHour(value: 11), views: 2000),
    Statistic(hour: Date().updateHour(value: 12), views: 56000),
    Statistic(hour: Date().updateHour(value: 13), views: 7800),
    Statistic(hour: Date().updateHour(value: 14), views: 1800),
    Statistic(hour: Date().updateHour(value: 15), views: 1900),
    Statistic(hour: Date().updateHour(value: 16), views: 12300),
    Statistic(hour: Date().updateHour(value: 17), views: 1002330),
    Statistic(hour: Date().updateHour(value: 18), views: 1232000),
    Statistic(hour: Date().updateHour(value: 19), views: 7571000),
    Statistic(hour: Date().updateHour(value: 20), views: 791000),
    Statistic(hour: Date().updateHour(value: 21), views: 9671000),
    Statistic(hour: Date().updateHour(value: 22), views: 2131000),
    Statistic(hour: Date().updateHour(value: 23), views: 44231000)
    
]
