//
//  FriendsViewController.swift
//  Weather
//
//  Created by Евгений Иванов on 10/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

struct Section {
    
    enum Properties: String {
        case letter
        case friends
    }
    //    dynamic var letters: String = ""
    //    //    dynamic var sectionObjects: Results<User>
    //    var sectionObjects = List<User>()
    //    convenience init(letter: String, users: [User] = []) {
    //        self.init()
    //        self.letters = letter
    //        self.sectionObjects.append(objectsIn: users)
    //    }
    //    override static func primaryKey() -> String? {
    //        return Properties.letters.rawValue
    //    }
    var letter: String
    var friends: [User]
    
//    init(_ letter: String, _ friend: User) {
//        self.letter = letter
//        self.friends = [User]()
//        self.friends.append(friend)
//    }
}

class FriendsViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    private let networkService = NetworkService()
    var notificationToken: NotificationToken?
    var friendsSections = [Section]()
    var selectedIndex: Int?
    var users: Results<User>? = DatabaseService.get(User.self)?.sorted(byKeyPath: "name")
    private func makeSections(_ query: String = "") {
        guard let users = users else { return }
        var friends = [User()]
        friendsSections.removeAll()
        if !query.isEmpty {
            friends = Array(users).filter({ $0.name.lowercased().contains(query.lowercased()) })
        } else {
            friends = Array(users)
        }
        friendsSections = Dictionary(grouping: friends, by: { $0.name.first! })
            .map { Section(letter: String($0.key), friends: $0.value) }
            .sorted { $0.letter < $1.letter }
    }
    
    @objc func hideKeyboard() {
        tableView?.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "Header", bundle: nil),
            forHeaderFooterViewReuseIdentifier: "Header")
        
        notificationToken = users?.observe{ [weak self] changes in
            guard let self = self else {return}
            
            switch changes {
            case .initial(_):
                self.tableView.reloadData()
            case .update(_):
                self.makeSections()
                self.tableView.reloadData()
            case .error(let error):
                self.showAlert(error: error)
            }
        }
        
        networkService.loadUserFriendsAlamofire() { [weak self] (users: [User]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let friends = users, let self = self else { return }
            DatabaseService.deleteData(type: User.self)
            DatabaseService.save(data: friends.filter{!$0.name.lowercased().contains("deleted")})
        }
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        hideKeyboardGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return friendsSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friendsSections[section].friends.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? Header else { return UIView() }
        let headerLetters = friendsSections[section].letter
        header.headerLabel.text = String(headerLetters)
        
        return header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendViewCell else { return UITableViewCell() }
        let friend = friendsSections[indexPath.section].friends[indexPath.row]
        cell.configure(with: friend)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowFriendPhotos",
        let vc = segue.destination as? FriendsCollectionViewController {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let user = friendsSections[indexPath.section].friends[indexPath.row]
                vc.user = user
            }
        }
    }
}

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.makeSections(searchText)
        self.tableView.reloadData()
    }
}
