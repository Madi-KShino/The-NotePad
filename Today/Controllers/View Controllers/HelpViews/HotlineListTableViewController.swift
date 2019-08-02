//
//  HotlineListTableViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/27/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class HotlineListTableViewController: UITableViewController {
    
    var titles = ["Abuse",
                  "Suicide/Self Harm",
                  "LGBTQ",
                  "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HotlineController.sharedInstance.loadHotlineData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    //Table View Data
    override func numberOfSections(in tableView: UITableView) -> Int {
        return HotlineController.sharedInstance.categories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HotlineController.sharedInstance.categories[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return titles[0]
        case 1:
            return titles[1]
        case 2:
            return titles[2]
        case 3:
            return titles[3]
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "hotlineCell", for: indexPath) as? HotlineTableViewCell else { return UITableViewCell() }

        let sections = HotlineController.sharedInstance.categories
        let helplinesToDisplay = sections[indexPath.section][indexPath.row]
        cell.hotline = helplinesToDisplay
        cell.updateViews()
        
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
    
    //Pop off VC

}
