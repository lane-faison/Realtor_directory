//
//  DirectoryVC.swift
//  Realtor Directory
//
//  Created by Lane Faison on 7/3/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DirectoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let url = "http://www.denverrealestate.com/rest.php/mobile/realtor/list?app_key=f7177163c833dff4b38fc8d2872f1ec6"

    var realtorArray = [Realtor]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        downloadRealtorData()
    
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if realtorArray.count > 0 {
            return realtorArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RealtorCell", for: indexPath) as? RealtorCell {
            return cell
        } else {
            return RealtorCell()
        }
    }
    
    func downloadRealtorData() {
        Alamofire.request(url).responseJSON { (response) -> Void in
            
            if let value = response.result.value {
                let json = JSON(value)
//                print(json.array!)
                
                for realtor in json.array! {
                    let first_name = realtor["first_name"].stringValue.capitalized
                    let last_name = realtor["last_name"].stringValue.capitalized
                    let id = realtor["id"].stringValue
                    let rebrand = realtor["rebrand"].stringValue.capitalized
                    let office = realtor["office"].stringValue.capitalized
                    let is_team = realtor["is_team"].boolValue
                    let phone_number = realtor["phone_number"].stringValue
                    let photo = realtor["photo"].stringValue
                    let title = realtor["title"].stringValue.capitalized
                    
                    let newRealtor = Realtor(first_name: first_name, last_name: last_name, id: id, is_team: is_team, rebrand: rebrand, photo: photo, title: title, phone_number: phone_number, office: office)
                    
                    self.realtorArray.append(newRealtor)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}







