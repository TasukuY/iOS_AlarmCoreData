//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Tasuku Yamamoto on 4/21/22.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabledButton: UIButton!
    
    
    //MARK: - Properties
    var alarm: Alarm?
    var isAlarmOn = true
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    //MARK: - IBActions
    @IBAction func alarmIsEnabledButtonTapped(_ sender: UIButton) {
        if let alarm = alarm {
            AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
            isAlarmOn = alarm.isEnabled
        }else {
            isAlarmOn = !isAlarmOn
        }
        designIsEnabledButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let alarmTitle = alarmTitleTextField.text,
              !alarmTitle.isEmpty
        else { return }
        let fireDate = alarmFireDatePicker.date
        
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, newTitle: alarmTitle, newFireDate: fireDate, isEnabled: isAlarmOn)
        }else {
            AlarmController.shared.createAlarm(withTitle: alarmTitle, and: fireDate)
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Methods
    func updateView(){
        guard let alarm = alarm,
              let fireDate = alarm.fireDate
        else { return }
        alarmFireDatePicker.date = fireDate
        alarmTitleTextField.text = alarm.title
        isAlarmOn = alarm.isEnabled
        designIsEnabledButton()
    }
    
    func designIsEnabledButton(){
        switch isAlarmOn {
        case true:
            alarmIsEnabledButton.backgroundColor = .black
            alarmIsEnabledButton.setTitle("Enabled", for: .normal)
        case false:
            alarmIsEnabledButton.backgroundColor = .darkGray
            alarmIsEnabledButton.setTitle("Disabled", for: .normal)
        }
    }
    
}
