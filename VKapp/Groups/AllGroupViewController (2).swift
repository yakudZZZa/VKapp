//
//  AllGroupViewController.swift
//  Weather
//
//  Created by Евгений Иванов on 10/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

struct Group {
    let name: String
    let image: UIImage?
}

class AllGroupViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allGroups = [
        Group(name: "Мемасики", image: UIImage(named: "vk")),
        Group(name: "Шаверма-Патруль", image: UIImage(named: "deactivated_tir1")),
        Group(name: "Любители подлёдной ловли", image: UIImage(named: "deactivated_tir1")),
        Group(name: "Мамочки спешат на помощь бездомным котятам", image: UIImage(named: "deactivated_tir1")),
        Group(name: "ЕГЭ на 5+", image: UIImage(named: "vk")),
        Group(name: "Поделки своими руками из грязи", image: UIImage(named: "deactivated_tir1")),
        Group(name: "Барахлока Екатеринбурга", image: UIImage(named: "deactivated_tir1")),
        Group(name: "Доставка готовой еды", image: UIImage(named: "deactivated_tir1")),
        Group(name: "Итальянские кухни от производителя", image: UIImage(named: "deactivated_tir1")),
        Group(name: "Роллы из гречки и селедки", image: UIImage(named: "deactivated_tir1"))
    ]
    
    var filteredGroups = [Group]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        filteredGroups = allGroups

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupViewCell
        let group = filteredGroups[indexPath.row]
        cell.groupName.text = group.name
        cell.groupAvatar.image = group.image
        

        return cell
    }
    
}

extension AllGroupViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            filteredGroups = allGroups
            tableView.reloadData()
            return
        }
        
        filteredGroups = filteredGroups.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil }

        tableView.reloadData()
    }
    
}
