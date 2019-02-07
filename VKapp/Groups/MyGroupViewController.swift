//
//  MyGroupViewController.swift
//  Weather
//
//  Created by Евгений Иванов on 10/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit
import RealmSwift

class MyGroupViewController: UITableViewController {
    
    private let networkService = NetworkService()
    var myGroups: Results<Group>? = DatabaseService.get(Group.self)?.sorted(byKeyPath: "name")
    var myGroupsSorted = [Group]()
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.loadUserGroupsAlamofire() { [weak self] (groups, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let groups = groups, let self = self else { return }
            let _ = try? DatabaseService.save(groups)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        notificationToken = myGroups?.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial(_):
                self.tableView.reloadData()
            case .update(_, let dels, let ins, let mods):
                self.tableView.applyChanges(deletions: dels, insertions: ins, updates: mods)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupsCell", for: indexPath) as? MyGroupsViewCell,
            let group = myGroups?[indexPath.row]
            else { return UITableViewCell() }
        
        cell.groupName.numberOfLines = 0
        cell.groupName.text = group.name
        cell.groupAvatar.kf.setImage(with: URL(string: group.photoUrlString))
        
        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "addGroup" else { return }
        let allGroupViewController = segue.source as! AllGroupViewController
        guard let indexPath = allGroupViewController.tableView.indexPathForSelectedRow else { return }
        let group = allGroupViewController.groups[indexPath.row]
        guard !(myGroups?.contains(group))! else { return }
        let _ = try? DatabaseService.save([group])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let group = myGroups?[indexPath.row] else { return }
            let _ = try? DatabaseService.deleteOne(group)
        }
    }
}
