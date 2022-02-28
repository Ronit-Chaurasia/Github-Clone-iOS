//
//  Utilities.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 10/02/22.
//

//import Foundation
import UIKit

extension UIImageView {
    func makeImageCircular(){
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        return localDate
    }
}

class Utilities{
    static func roundOff(_ number: Int) -> String{
        let nf = NumberFormatter()
        nf.roundingMode = .down
        nf.maximumFractionDigits = 1
        
        let number = Double(number)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        
        if billion >= 1.0 {
            return nf.string(for: billion)! + "B"
        }
        else if million >= 1.0 {
            return nf.string(for: million)! + "M"
        }
        else if thousand >= 1.0 {
            return nf.string(for: thousand)! + "K"
        }
        else {
            return "\(Int(number))"
        }
    }
    
    static func dateDifference(repoDate: String) -> String{

        let now = Date().localDate()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
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
                return "last updated an year ago"
            }
            else if(year > 0){
                return "last updated " + String(year) + " years ago"
            }
            else if(month == 1){
                return "last updated a month ago"
            }
            else if(month > 0){
                return "last updated " + String(month) + " months ago"
            }
            else if(day == 1){
                return "last updated a day ago"
            }
            else if(day > 0){
                return "last updated " + String(day) + " days ago"
            }
            else if(hour == 1){
                return "last updated an hour ago"
            }
            else if(hour > 0){
                return "last updated " + String(hour) + " hours ago"
            }
            else if(minute == 1){
                return "last updated a minute ago"
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
