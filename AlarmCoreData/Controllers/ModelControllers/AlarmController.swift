//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Tasuku Yamamoto on 4/21/22.
//

import Foundation
import CoreData

class AlarmController {
    //MARK: - Properties
    static let shared = AlarmController()
    var alarms: [Alarm] = []
    
    private lazy var fetchRequest: NSFetchRequest<Alarm> = {
        let request = NSFetchRequest<Alarm>(entityName: "Alarm")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //MARK: - CRUD funcs
    func createAlarm(withTitle title: String, and fireDate: Date){
        let newAlarm = Alarm(title: title, fireDate: fireDate, isEnabled: true)
        alarms.append(newAlarm)
        CoreDataStack.saveContext()
    }

    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool){
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isEnabled
        CoreDataStack.saveContext()
    }

    func toggleIsEnabledFor(alarm: Alarm){
        alarm.isEnabled = !alarm.isEnabled
        CoreDataStack.saveContext()
    }

    func delete(alarm: Alarm){
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
        CoreDataStack.context.delete(alarm)
        CoreDataStack.saveContext()
    }

    //MARK: - Methods
    func fetchAlarms(){
        let fetchedAlarms = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        self.alarms = fetchedAlarms
    }
    
    
}//End of class
