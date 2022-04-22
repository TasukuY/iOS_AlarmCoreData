//
//  Alarm+Convienience.swift
//  AlarmCoreData
//
//  Created by Tasuku Yamamoto on 4/21/22.
//

import Foundation
import CoreData

extension Alarm {
    @discardableResult convenience init(title: String, fireDate: Date,
                                        isEnabled: Bool,
                                        context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.uuidString = UUID().uuidString
        self.title = title
        self.fireDate = fireDate
        self.isEnabled = isEnabled
    }
}//End of extension
