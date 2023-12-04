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
    static func showYesNoDialog(vc : UIViewController , title : String , text : String , handler : @escaping (_ alert : UIAlertAction)->())
    {
        let alert = UIAlertController(title: title.localize(), message: text.localize(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes".localize(), style: .destructive , handler: handler) )
        alert.addAction(UIAlertAction(title: "No".localize(), style: .cancel))
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
    
    static func getTopViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        // If the base view controller has a presented view controller, we recursively call this function to get the topmost view controller
        if let presented = base?.presentedViewController {
            return getTopViewController(presented)
        }
        
        // If the base view controller is a UINavigationController, we get its visible view controller (top of the stack)
        if let navigation = base as? UINavigationController {
            return getTopViewController(navigation.visibleViewController)
        }
        
        // If the base view controller is a UITabBarController, we get its currently selected view controller
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopViewController(selected)
            }
        }
        
        // If none of the above, we're at the top of the hierarchy
        return base
    }
}
