//
//  PersonViewModel.swift
//  MVVM-SimpleEx
//
//  Created by Wonseok Lee on 2021/11/02.
//

import Foundation

public class PersonViewModel {
    let userName = Observable("아무개(0)")
    let birthYear = Observable(2021)
    
    init() {
        print("<<<< ViewModel Initializing >>>>")
    }

    func calculateBirthYear(name: String, age: String) {
        guard let age = Int(age) else { return }
        userName.value = name + "(\(age))"
        birthYear.value = (2021 - age)+1
    }
}
