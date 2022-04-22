//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Tasuku Yamamoto on 4/22/22.
//

import Foundation
import UserNotifications

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm){
        let content = UNMutableNotificationContent()
        content.title = "Time to get up!"
        content.body = "Alarm \(alarm.title ?? "") is going off"
        content.sound = UNNotificationSound.default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate ?? Date())
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        guard let alarmID = alarm.uuidString,
              !alarmID.isEmpty
        else { return }
        
        let request = UNNotificationRequest(identifier: alarmID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add notification request: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm){
        guard let alarmID = alarm.uuidString,
              !alarmID.isEmpty
        else { return }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarmID])
    }
    
}//End of extension
