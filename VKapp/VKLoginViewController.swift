//
//  VKLoginViewController.swift
//  Geekbrains Weather
//
//  Created by user on 29.09.2018.
//  Copyright © 2018 Andrey Antropov. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class VKLoginViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    private let networkService = NetworkService()
    
    private var token: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6791370"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.85")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
}

extension VKLoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard   let url = navigationResponse.response.url,
                url.path == "/blank.html",
                let fragment = url.fragment
            else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
//        print(params)
        
        guard   let token = params["access_token"],
                let userId = Int(params["user_id"]!)
                else {
            decisionHandler(.cancel)
            return
        }
        
        print(token, userId)
        Session.shared.token = token
        Session.shared.userId = userId
        
//        loadUserFriendsAlamofire()
//        networkService.loadUserPhotosAlamofire()
//        loadUserGroupsAlamofire()
//        searchGroupsAlamofire()
        
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: "VKLogin", sender: nil)
    }
    
//    func loadUserFriendsAlamofire() {
//
//        let baseUrl = "https://api.vk.com"
//
//        let path = "/method/friends.get"
//
//        let params: Parameters = [
//            "access_token": Session.shared.token,
//            "order": "name",
//            "fields": "city,photo_id,photo_max_orig",
//            "offset": "5",
//            "count": "3",
//            "v": "5.92"
//        ]
//
//        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
//            switch response.result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let value):
//                print(value)
//            }
//        }
//    }
//
//    func loadUserPhotosAlamofire() {
//
//        let baseUrl = "https://api.vk.com"
//
//        let path = "/method/photos.get"
//
//        let params: Parameters = [
//            "access_token": Session.shared.token,
//            "album_id": "profile",
//            "rev": "0",
//            "offset": "6",
//            "count": "2",
//            "v": "5.92"
//        ]
//
//        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
//            switch response.result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let value):
//                print(value)
//            }
//        }
//    }
//
//    func loadUserGroupsAlamofire() {
//
//        let baseUrl = "https://api.vk.com"
//
//        let path = "/method/groups.get"
//
//        let params: Parameters = [
//            "access_token": Session.shared.token,
//            "filter": "publics",
//            "extended": "1",
//            "count": "10",
//            "v": "5.92"
//        ]
//
//        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
//            switch response.result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let value):
//                print(value)
//            }
//        }
//    }
//
//    func searchGroupsAlamofire() {
//
//        let baseUrl = "https://api.vk.com"
//
//        let path = "/method/groups.search"
//
//        let params: Parameters = [
//            "access_token": Session.shared.token,
//            "q": "Music",
//            "offset": "3",
//            "count": "3",
//            "v": "5.92"
//        ]
//
//        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON { (response) in
//            switch response.result {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let value):
//                print(value)
//            }
//        }
//    }
}
