//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Tasuku Yamamoto on 4/21/22.
//

import UIKit

protocol AlarmTableViewCellDelegate: AnyObject {
    func alarmWasToggled(sender: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    //MARK: - Properties
    weak var delegate: AlarmTableViewCellDelegate?
    
    //MARK: - IBActions
    @IBAction func isEnabledSwitchToggled(_ sender: UISwitch) {
        delegate?.alarmWasToggled(sender: self)
    }
    
    //MARK: - Methods
    func updateViews(alarm: Alarm){
        alarmTitleLabel.text = alarm.title
        isEnabledSwitch.isOn = alarm.isEnabled ? true : false
        alarmFireDateLabel.text = alarm.fireDate?.stringValue() ?? "Alarm dates has not been provided"
    }

}//End of class
