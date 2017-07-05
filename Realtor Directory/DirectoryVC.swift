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

class DirectoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let url = "http://www.denverrealestate.com/rest.php/mobile/realtor/list?app_key=f7177163c833dff4b38fc8d2872f1ec6"

    var realtorArray = [Realtor]()
    var sortOptions = ["First name A-Z","First name Z-A","Last name A-Z","Last name Z-A"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        sortPicker.delegate = self
        sortPicker.dataSource = self
        
        sortPicker.isHidden = true
        
        downloadRealtorData()
    }
    
    // SEGUE FUNCTIONS
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if realtorArray.count > 0 {
            let realtor = realtorArray[indexPath.row]
            performSegue(withIdentifier: "RealtorDetails", sender: realtor)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RealtorDetails" {
            if let destination = segue.destination as? RealtorDetailsVC {
                if let realtor = sender as? Realtor {
                    destination.realtorClicked = realtor
                }
            }
        }
    }
    
    // TABLEVIEW FUNCTIONS
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
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
          
            // Reduce the image size to a width of 50px before adding it to the RealtorCell
            let thumbnailUrl = realtorArray[indexPath.row]._photo + "/width/50"
            let url = URL(string: thumbnailUrl)
            let data = try? Data(contentsOf: url!)
            let portrait = UIImage(data: data!)
            
            cell.thumbPortrait.image = portrait
            cell.name.text = realtorArray[indexPath.row]._first_name + " " + realtorArray[indexPath.row]._last_name
            cell.phoneNumber.text = realtorArray[indexPath.row]._phone_number
            
            return cell
        } else {
            return RealtorCell()
        }
    }
    
    // PICKERVIEW FUNCTIONS
    
    @IBAction func sortBtnTapped(_ sender: Any) {
        
        if sortPicker.isHidden == true {
            sortPicker.isHidden = false
        } else {
            sortPicker.isHidden = true
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return sortOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return sortOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.sortPicker.isHidden = true

        // SORT OPTIONS FOR DIRECTORY
        if row == 0 {
            self.realtorArray.sort { $0._first_name < $1._first_name }
            self.tableView.reloadData()
        }
        if row == 1 {
            self.realtorArray.sort { $0._first_name > $1._first_name }
            self.tableView.reloadData()
        }
        if row == 2 {
            self.realtorArray.sort { $0._last_name < $1._last_name }
            self.tableView.reloadData()
        }
        if row == 3 {
            self.realtorArray.sort { $0._last_name > $1._last_name }
            self.tableView.reloadData()
        }
    }
    
    // ALAMOFIRE DATA REQUEST
    
    func downloadRealtorData() {
        Alamofire.request(url).responseJSON { (response) -> Void in
            
            if let value = response.result.value {
                let json = JSON(value)
                
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
                    
                    self.realtorArray.sort { $0._first_name < $1._first_name }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
}
