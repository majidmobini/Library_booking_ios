//
//  Utils.swift
//  Library booking
//
//  Created by Majid Mobini on 11/28/23.
//

import Foundation
import UIKit

class Utils : NSObject
{
    static func showMessageDialog( vc : UIViewController , title : String , text : String)
    {
        let alert = UIAlertController(title: title.localize(), message: text.localize(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".localize(), style: .cancel))
        vc.present(alert, animated: true)
    }
    static func formatDate(date : Date) -> String
    {
        return formatDate(intDate: date.getIntTimeStamp())
    }
    static func formatDate(intDate : Int) -> String
    {
        let date = Date(timeIntervalSince1970: Double(intDate))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        //dateFormatter.dateStyle = .medium
        //dateFormatter.timeStyle = .short
        let formattedDate = dateFormatter.string(from:date)
        return formattedDate
    }
}
