//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by Tasuku Yamamoto on 4/21/22.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AlarmController.shared.fetchAlarms()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.cellIdentifier, for: indexPath) as? AlarmTableViewCell
        else { return UITableViewCell()}
        cell.indexPath = indexPath
        cell.delegate = self
        
        let alarmToDisplay = AlarmController.shared.alarms[indexPath.row]
        cell.updateViews(alarm: alarmToDisplay)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarmToDelete = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarmToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == Strings.segueToDetailVC {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? AlarmDetailTableViewController
            else { return }
            
            let alarmToSend = AlarmController.shared.alarms[indexPath.row]
            destination.alarm = alarmToSend
        }
    
    }

}//End of class

extension AlarmListTableViewController: AlarmTableViewCellDelegate{
    func alarmWasToggled(sender: AlarmTableViewCell) {
        guard let indexPath = sender.indexPath else { return }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
        
        sender.updateViews(alarm: alarm)
    }
}
