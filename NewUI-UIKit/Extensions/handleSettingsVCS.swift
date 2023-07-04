//
//  handleSettingsVCS.swift
//  NewUI-UIKit
//
//  Created by Ahmad medo on 04/07/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func handleStoryBoards(sbName: String,ID:String,navTitle: String) -> UIViewController {
        let sb = UIStoryboard(name: sbName, bundle: nil)
        
        let vc = sb.instantiateViewController(identifier: ID)
        
        navigationItem.backButtonTitle = ""
        vc.navigationItem.title = navTitle.localized
        return vc
    }
}
