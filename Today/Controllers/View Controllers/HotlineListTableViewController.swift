//
//  HotlineListTableViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/27/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class HotlineListTableViewController: UITableViewController {

    var sections: [[Hotline]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HotlineController.sharedInstance.loadHotlineData { (success) in
            if success {
                self.sections = [HotlineController.sharedInstance.abuseHotlines,
                                 HotlineController.sharedInstance.suicideHotlines,
                                 HotlineController.sharedInstance.lgbtqHotlines,
                                 HotlineController.sharedInstance.otherHotlines ]
                self.tableView.reloadData()
            } else { return }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //Table View Data
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hotlineCell", for: indexPath)

        let helplinesToDisplay = sections[indexPath.section][indexPath.row]
        cell.textLabel?.text = helplinesToDisplay.name
        

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
