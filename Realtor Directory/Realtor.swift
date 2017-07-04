//
//  Realtor.swift
//  Realtor Directory
//
//  Created by Lane Faison on 7/3/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class Realtor {
    
    let url = "http://www.denverrealestate.com/rest.php/mobile/realtor/list?app_key=f7177163c833dff4b38fc8d2872f1ec6"

    var _first_name: String!
    var _last_name: String!
    var _id: String!
    var _is_team: Bool!
    var _rebrand: String!
    var _photo: String!
    var _title: String!
    var _phone_number: String!
    var _office: String!

    var first_name: String {
        if _first_name == nil {
            _first_name = ""
        }
        return _first_name
    }
    
    var last_name: String {
        if _last_name == nil {
            _last_name = ""
        }
        return _last_name
    }
    
    var id: String {
        if _id == nil {
            _id = ""
        }
        return _id
    }
    
    var is_team: Bool {
        if _is_team == nil {
            _is_team = false
        }
        return _is_team
    }
    
    var rebrand: String {
        if _rebrand == nil {
            _rebrand = ""
        }
        return _rebrand
    }
    
    var photo: String {
        if _photo == nil {
            _photo = ""
        }
        return _photo
    }
    
    var title: String {
        if _title == nil {
            _title = ""
        }
        return _title
    }
    
    var phone_number: String {
        if _phone_number == nil {
            _phone_number = ""
        }
        return _phone_number
    }
    
    var office: String {
        if _office == nil {
            _office = ""
        }
        return _office
    }
    
    init(first_name: String, last_name: String, id: String, is_team: Bool, rebrand: String, photo: String, title: String, phone_number: String, office: String) {
        self._first_name = first_name
        self._last_name = last_name
        self._id = id
        self._is_team = is_team
        self._rebrand = rebrand
        self._photo = photo
        self._title = title
        self._phone_number = phone_number
        self._office = office
    }
}
