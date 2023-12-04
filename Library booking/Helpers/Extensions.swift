//
//  Extensions.swift
//  Library booking
//
//  Created by Majid Mobini on 11/25/23.
//

import UIKit

extension UIView
{
    func roundCorner()
    {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
}
extension UIButton {
    func makeRoundButton()
    {
        self.layer.cornerRadius = self.frame.height/2
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: -2, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.masksToBounds = false

        
    }
    
}

extension String {
    func localize () -> String
    {
        return NSLocalizedString(self, bundle: .main, comment: "")
    }
}

extension URL {

    static var documents: URL {
        return FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension Date {
   func getIntTimeStamp() -> Int
    {
        return (Int(self.timeIntervalSince1970))
    }
}

extension UIViewController {

    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

extension UIAlertController {
    func fixIpad(view : UIView)
    {
        if UIDevice.current.userInterfaceIdiom == .pad
        {
               // Set up the popover presentation controller for iPad
               if let popoverController = self.popoverPresentationController {
                   // Configure the popover controller here, like setting the sourceView
                   // This should typically be a UIBarButtonItem or a UIView instance that you want the popover to point to
                   popoverController.sourceView = view
                   // You can adjust this rect to move the popover's arrow to the appropriate location
                   popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
                   popoverController.permittedArrowDirections = [] // Adjust if you want an arrow pointing to the sourceRect
               }
        }
    }
}

