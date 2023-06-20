//
//  ViewController.swift
//  Project21
//
//  Created by BTSL.SAJID on 20/6/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
        
        
    }

    @objc func registerLocal() {
        //request permission to to send local notifications
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("valo")
            } else {
                print("kharap")
            }
        }
    }
    
    @objc func scheduleLocal() {
        //configure all the data needed to schedule a notificatio
        
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
}

