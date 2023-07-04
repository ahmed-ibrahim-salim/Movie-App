//
//  handleNavTitle.swift
//  NewUI-UIKit
//
//  Created by Ahmad medo on 04/07/2023.
//

import UIKit


extension UINavigationController {
    func handleNavBar(navigationItem: UINavigationItem,Title: String){
        navigationItem.title = Title.localized
    }
}
