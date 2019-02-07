//
//  FriendsCollectionViewController.swift
//  Weather
//
//  Created by Евгений Иванов on 10/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher


class FriendsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var user = User()
    let leftAndRightPaddings: CGFloat = 20.0
    let numberOfItemsPerRow: CGFloat = 7.0
    let screenSize: CGRect = UIScreen.main.bounds
    private let reuseIdentifier = "photoCollection"
    private let networkService = NetworkService()
    var photoss: Results<PhotoClass>?
    var notificationToken: NotificationToken?
    let layout = UICollectionViewLayout()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        networkService.loadUserPhotosAlamofire(owner_id: user.id) { [weak self] (photos, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let photos = photos, let self = self else { return }
            DatabaseService.save(data: photos)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.photoss = DatabaseService.get(PhotoClass.self)?.filter("ownerId = %@", self.user.id)
        
        notificationToken = photoss?.observe{ [weak self] changes in
            switch changes {
            case .initial(_), .update(_, _, _, _):
                self?.collectionView.reloadData()
            case .error(let error):
                self?.showAlert(error: error)
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoss?.count ?? 0
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = (screenSize.width-leftAndRightPaddings)/numberOfItemsPerRow
        
        return CGSize(width: width, height: width)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FriendCollectionViewCell,
            let photo = photoss?[indexPath.row] else { return UICollectionViewCell() }
        cell.userPhoto.kf.setImage(with: URL(string: photo.urlString))
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        collectionView.isPagingEnabled = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        print("нажата ячейка \(String(describing: cell))")
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        
        return UIEdgeInsets(top: 20, left: 8, bottom: 5, right: 8)
    }
    
}
