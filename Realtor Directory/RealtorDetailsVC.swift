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
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var portrait: RoundedOutlineImage!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var office: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GREEN GRADIENT AT BASE OF VIEW
        
        gradientLayer.frame = self.view.bounds
        let color1 = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0).cgColor
        let color2 = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0).cgColor
        let color3 = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0).cgColor
        let color4 = UIColor(red: 104/255, green: 159/255, blue: 56/255, alpha: 1.0).cgColor
        gradientLayer.colors = [color1,color2,color3,color4]
        gradientLayer.locations = [0.0,0.25,0.75,0.9]
        self.view.layer.addSublayer(gradientLayer)
        
        generateRandomHome()
        showRealtorDetails()
    }
    
    func generateRandomHome() {
        
        let number = arc4random_uniform(8) + 1
        houseImage.image = UIImage(named: "home\(number)")
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
}
