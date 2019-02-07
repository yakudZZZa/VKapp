//
//  AllGroupViewController.swift
//  Weather
//
//  Created by Евгений Иванов on 10/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

//struct Group {
//    let name: String
//    let image: UIImage?
//}
//extension Group: Equatable {
//    static func == (lhs: Group, rhs: Group) -> Bool {
//        return lhs.name == rhs.name
//    }
//}

class AllGroupViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var groups = [Group]()
//    var sortedGroups = [Group]()
    var filterSortedGroups = [Group]()
    private let networkService = NetworkService()
    
//    var allGroups = [
//        Group(name: "Мемасики", image: UIImage(named: "vk")),
//        Group(name: "Шаверма-Патруль", image: UIImage(named: "deactivated_tir1")),
//        Group(name: "Любители подлёдной ловли", image: UIImage(named: "deactivated_tir1")),
//        Group(name: "Мамочки спешат на помощь бездомным котятам", image: UIImage(named: "deactivated_tir1")),
//        Group(name: "ЕГЭ на 5+", image: UIImage(named: "deactivated_tir1")),
//        Group(name: "Поделки своими руками из грязи", image: UIImage(named: "deactivated_tir1")),
//        Group(name: "Барахлока Екатеринбурга", image: UIImage(named: "deactivated_tir1")),
//        Group(name: "Доставка готовой еды", image: UIImage(named: "vk")),
//        Group(name: "Итальянские кухни от производителя", image: UIImage(named: "deactivated_tir1")),
//        Group(name: "Роллы из гречки и селедки", image: UIImage(named: "deactivated_tir1")),
//    ]
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchBar.placeholder = "Поиск группы"
        
        
//        sortedGroups = allGroups.sorted { $0.name < $1.name }
//        filterSortedGroups = sortedGroups
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        networkService.loadUserGroupsAlamofire() { [weak self] (groups, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            guard let groups = groups, let self = self else { return }
//            self.groups = groups
////            self.sortedGroups = self.groups.sorted { $0.name < $1.name }
//            self.filterSortedGroups = self.groups
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath) as! AllGroupViewCell
        let group = groups[indexPath.row]
        cell.groupName.numberOfLines = 0
        cell.groupName.text = group.name
        cell.groupAvatar.kf.setImage(with: URL(string: group.photoUrlString))

        return cell
    }
    
}

extension AllGroupViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            //            filterSortedGroups = sortedGroups
            tableView.reloadData()
            return
        }
        networkService.searchGroupsAlamofire(searchText: searchText) { [weak self] (groups, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let groups = groups, let self = self else { return }
            self.groups = groups
//            self.filterSortedGroups = self.groups
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        
//        filterSortedGroups = groups.filter {$0.name.range(of: searchText, options: .caseInsensitive) != nil}
        
//        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
}
