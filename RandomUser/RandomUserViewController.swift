//
//  ViewController.swift
//  RandomUser
//
//  Created by Keuahn Lumanog on 1/3/19.
//  Copyright © 2019 Keuahn Lumanog. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RandomUserViewController: UITableViewController {

    var user = [User]()
    var refreshController: UIRefreshControl?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestForRandomUser()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        tableView.tableFooterView = UIView()
    }

    func addRefreshControl() {
        self.refreshController = UIRefreshControl()
        self.refreshController?.addTarget(self, action: #selector(self.requestForRandomUser), for: UIControl.Event.valueChanged)
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshController
        } else {
            tableView.addSubview(refreshController!)
        }
    }

    @objc func requestForRandomUser() {
        self.user.removeAll()
        for _ in 1...3 {
            let randomUserUrl = "https://randomuser.me/api/?format=json"
            Alamofire.request(randomUserUrl).responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Result: \(response.result)")                         // response serialization result
                if let data = response.data {
                    var json = try? JSON(data: data)
                    print("JSON: \(String(describing: json))")
                    if let resultsArray = json?["results"].array {
                        let firstName = resultsArray.first?["name"]["first"].string ?? ""
                        let lastName = resultsArray.first?["name"]["last"].string ?? ""
                        let email = resultsArray.first?["email"].string ?? ""
                        let pictureUrl = resultsArray.first?["picture"]["thumbnail"].string ?? ""
                        self.user.append(User(firstName: firstName, lastName: lastName, email: email, pictureUrl: pictureUrl))
                        self.tableView.reloadData()
                    }
                }
            }
        }
        refreshControl?.endRefreshing()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.user.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RandomUserCell", for: indexPath) as? RandomUserCell
        if self.user.count == 0 {
            return cell!
        }else {
            if indexPath.row < self.user.count {
                let userData = self.user[indexPath.row]
                cell?.configureCell(firstName: userData.firstName, lastName: userData.lastName, email: userData.email, pictureUrl: userData.pictureUrl)
            }
            return cell!
        }
    }

}
