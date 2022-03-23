//
//  TabbarController.swift
//  NewUI-UIKit
//
//  Created by ahmadibrahim on 12/6/21.
//

import UIKit

class TabController: UITabBarController, UITabBarControllerDelegate {

    @IBOutlet weak var bottomTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        bottomTabBar.tintColor = UIColor(rgb: 0xEE5F5B)
        bottomTabBar.unselectedItemTintColor = UIColor(rgb: 0xEE5F5B).withAlphaComponent(0.30)
        setSB()
    }

func hideTabbar(isHidden: Bool){
        tabBar.isHidden = isHidden
}
    
func setSB(){
    let homeVC = handleStoryBoards(sbName: "Home", Identifier: "HomeVC", itemTitle: "Home", itemImageName: "TBHomeIcon")
    let reservationsVC = handleStoryBoards(sbName: "Reserv", Identifier: "reservVC", itemTitle: "Reservation", itemImageName: "TBReservationIcon")
    let servicesVC = handleStoryBoards(sbName: "Services", Identifier: "ServicesVC", itemTitle: "Services", itemImageName: "TBServicesIcon")
    let offersVC = handleStoryBoards(sbName: "Offers", Identifier: "OffersVC", itemTitle: "Offers", itemImageName: "TBOffersIcon")
    let settingsVC = handleStoryBoards(sbName: "Settings", Identifier: "SettingsVC", itemTitle: "Settings", itemImageName: "TBSettingsIcon")

    viewControllers = [homeVC,reservationsVC,servicesVC,offersVC,settingsVC]
}
    
func handleStoryBoards(sbName:String,Identifier:String,itemTitle:String,itemImageName:String) -> UIViewController {
    let homeSB = UIStoryboard(name: sbName, bundle: nil)
    let homeNC = homeSB.instantiateViewController(withIdentifier: Identifier)
    homeNC.tabBarItem.title = itemTitle
    homeNC.tabBarItem.image = UIImage(named: itemImageName)
    return homeNC
    }

}



