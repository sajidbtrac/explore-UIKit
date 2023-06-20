//
//  ViewController.swift
//  Project21
//
//  Created by BTSL.SAJID on 20/6/23.
//

import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
        
        
    }

    //request permission to to send local notifications
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("valo")
            } else {
                print("kharap")
            }
        }
    }
    
    //configure all the data needed to schedule a notification
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        
        // if we want to remove all pending/ old notification (ex: sports score live uodate)
        center.removeAllPendingNotificationRequests()
        
        //what (notification contenct)
        let content = UNMutableNotificationContent()
        content.title = "Hello, I am Sajid!"
        content.body = "It's your phone, now at my control. ha ha ha!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customizeJkonoData": "haha"]
        content.sound = .default
        
        //when to show
        //here we can use calendar trigger/ interval trigger / geofence based on user’s location.
//        var dateComponenet = DateComponents()
//        dateComponenet.hour = 10
//        dateComponenet.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponenet, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true) // in every 5 sec
        
        // request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add the notification request
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more..", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customizeJkonoData"] as? String {
            print("Custom data recived: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the user swiped to unlock
                print("Default identifier")
            case "show":
                print("show more info")
            default:
                break
            }
        }
        completionHandler()
    }
}

