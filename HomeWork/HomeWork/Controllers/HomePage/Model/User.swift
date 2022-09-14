//
//  User.swift
//  HomeWork
//
//  Created by Muhammed Burkay Şendoğdu on 11.09.2022.
//

import UIKit

struct User{
    let name: String
    let surname: String
    let phoneNumber: String
    let gender: Gender
}

enum Gender: String, CaseIterable{
    case Male
    case Female
}
