//
//  main.swift
//  test_commandLine
//
//  Created by Wonseok Lee on 2021/05/31.
//

import Foundation

struct Address {
    var fullAddress: String
    var city: String
    
    init(fullAddress: String, city: String) {
        self.fullAddress = fullAddress
        self.city = city
    }
}

class Person {
    var name: String
    var address: Address
    
    init(name: String, address: Address) {
        self.name = name
        self.address = address
    }
}


var headquarters = Address(fullAddress: "123 Tutorial Street", city: "Appletown")
var ray = Person(name: "Ray", address: headquarters)
var brian = Person(name: "Brian", address: headquarters)
brian.address.fullAddress = "148 Tutorial Street"

print(ray.address.fullAddress)
