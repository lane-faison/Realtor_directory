//
//  RealtorDetailsVC.swift
//  Realtor Directory
//
//  Created by Lane Faison on 7/4/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class RealtorDetailsVC: UIViewController {

    var realtorClicked: Realtor?
    
    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var portrait: RoundedOutlineImage!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var office: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateRandomHome()
        showRealtorDetails()
    }

    func showRealtorDetails() {
      
        if realtorClicked != nil {
            
            let portraitUrl = (realtorClicked?._photo)! + "/width/200"
            let url = URL(string: portraitUrl)
            let data = try? Data(contentsOf: url!)
            let portraitPicture = UIImage(data: data!)
            
            let realtorName = (realtorClicked?._first_name)! + " " + (realtorClicked?._last_name)!
            
            portrait.image = portraitPicture
            name.text = realtorName
            office.text = realtorClicked?._office
            position.text = realtorClicked?._title
            phoneNumber.text = realtorClicked?._phone_number
        }
    }
    
    func generateRandomHome() {
       
        let number = arc4random_uniform(8) + 1
        houseImage.image = UIImage(named: "home\(number)")
    }

}
