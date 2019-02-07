//
//  NewsTableViewController.swift
//  Weather
//
//  Created by Евгений Иванов on 25/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

struct News {
    let text: String
    let image: UIImage?
    let likes: Int
    let isLiked: Bool
    let comments: Int
    let shares: Int
    let views: NSNumber
}

class NewsTableViewController: UITableViewController {
    
    var newsList = [
        News(text: "Кстати, элементы политического процесса призывают нас к новым свершениям, которые, в свою очередь, должны быть объективно рассмотрены соответствующими инстанциями.", image: UIImage(named: "China"), likes: 40, isLiked: false, comments: 28, shares: 15, views: 5500),
        News(text: "Таким образом, консультация с широким активом напрямую зависит от экспериментов, поражающих по своей масштабности и грандиозности.", image: UIImage(named: "goats"), likes: 30, isLiked: false, comments: 28, shares: 15, views: 500),
        News(text: "Задача организации, в особенности же существующая теория однозначно определяет каждого участника как способного принимать собственные решения касаемо глубокомысленных рассуждений.", image: UIImage(named: "China1"), likes: 50, isLiked: false, comments: 28, shares: 15, views: 8500),
        News(text: "Имеется спорная точка зрения, гласящая примерно следующее: ключевые особенности структуры проекта освещают чрезвычайно интересные особенности картины в целом, однако конкретные выводы, разумеется, объединены в целые кластеры себе подобных.", image: UIImage(named: "Houses"), likes: 60, isLiked: false, comments: 28, shares: 15, views: 15000),
        News(text: "Внезапно, действия представителей оппозиции набирают популярность среди определенных слоев населения, а значит, должны быть объединены в целые кластеры себе подобных.", image: UIImage(named: "Maldives"), likes: 53, isLiked: false, comments: 28, shares: 15, views: 111500),
        News(text: "Вот вам яркий пример современных тенденций - внедрение современных методик позволяет оценить значение стандартных подходов!", image: UIImage(named: "New_Zealand"), likes: 20, isLiked: false, comments: 28, shares: 15, views: 4500)
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return newsList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let news = newsList[indexPath.section]
        
        
//        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(NewsTableViewController.imageTapped))
        cell.newsLabel.numberOfLines = 0
        cell.newsLabel.text = news.text
        cell.commentCount.text = String(news.comments)
        cell.shareCount.text = String(news.shares)
        cell.likeCount.text = String(news.likes)
        cell.likeButton.setImage(UIImage(named: "grayHeart"), for: .normal)
        cell.commentButton.setImage(UIImage(named: "comment"), for: .normal)
        cell.shareButton.setImage(UIImage(named: "share"), for: .normal)
        cell.newsPic.image = news.image
//        cell.newsPic.addGestureRecognizer(pictureTap)
        cell.viewsCount.text = suffixNumber(number: news.views)

        // Configure the cell...

        return cell
    }
    
    func suffixNumber(number:NSNumber) -> String {
        
        var num:Double = number.doubleValue;
        let sign = ((num < 0) ? "-" : "" );
        num = fabs(num);
        
        if (num < 1000.0){
            return "\(sign)\(Int(num))";
        }
        
        let exp:Int = Int(log10(num) / 3.0 ); //log10(1000));
        let units:[String] = ["K","M","G","T","P","E"];
        let roundedNum:Double = round(10 * num / pow(1000.0,Double(exp))) / 10;
        
        return "\(sign)\(roundedNum)\(units[exp-1])";
    }
    
//    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
//        let imageView = sender.view as! UIImageView
//        let newImageView = UIImageView(image: imageView.image)
//        newImageView.frame = UIScreen.main.bounds
//        newImageView.backgroundColor = .black
//        newImageView.contentMode = .scaleAspectFit
//        newImageView.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullScreenImage))
//        newImageView.addGestureRecognizer(tap)
//        self.view.addSubview(newImageView)
//        self.navigationController?.isNavigationBarHidden = true
//        self.tabBarController?.tabBar.isHidden = true
//    }
//
//    @objc func dismissFullScreenImage(_ sender: UITapGestureRecognizer) {
//        self.navigationController?.isNavigationBarHidden = false
//        self.tabBarController?.tabBar.isHidden = false
//        sender.view?.removeFromSuperview()
//    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
