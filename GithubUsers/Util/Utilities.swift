//
//  Utilities.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 10/02/22.
//

import Foundation
import UIKit

//ibDesignable


extension UIImageView {
    func makeImageCircular(){
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

class Utilities{
    static func roundOff(number: Int) -> String{
        let number = Double(number)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        
        if billion >= 1.0 {
            return "\(round(billion*10)/10)B"
        } else if million >= 1.0 {
            return "\(round(million*10)/10)M"
        } else if thousand >= 1.0 {
            return ("\(round(thousand*10/10))K")
        } else {
            return "\(Int(number))"
        }
    }
    
    static func dateDifference(repoDate: String) -> String{

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let now = Date()
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 2
        
        if let date = dateFormatter.date(from: repoDate){
            
            let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
            
            let year = components.year ?? 0
            let month = components.month ?? 0
            let day = components.day ?? 0
            let hour = components.hour ?? 0
            let minute = components.minute ?? 0
            let second = components.second ?? 0

            
            if(year == 1){
                return "last updated " + String(year) + " year ago"
            }
            else if(year > 0){
                return "last updated " + String(year) + " years ago"
            }
            else if(month > 0){
                return "last updated " + String(month) + " months ago"
            }
            else if(day > 0){
                return "last updated " + String(day) + " days ago"
            }
            else if(hour > 0){
                return "last updated " + String(hour) + " hours ago"
            }
            else if(minute > 0){
                return "last updated " + String(minute) + " minutes ago"
            }
            else if(second > 0){
                return "last updated " + String(second) + " seconds ago"
            }
        }
        return ""
    }
}
