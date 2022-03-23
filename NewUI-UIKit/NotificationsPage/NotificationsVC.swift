//
//  NotificationsVC.swift
//  NewUI-UIKit
//
//  Created by ahmadibrahim on 12/8/21.
//

import UIKit


class NotificationsVC: UIViewController {
    
    var skip = 0
    var dataCount = 0
    var notificationsList = [Notification]()
    @IBOutlet weak var emptyNotificationStackV: UIStackView!
    @IBOutlet weak var notificationTable: UITableView!{
        didSet{
            notificationTable.tableFooterView = UIView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let tabbar = tabBarController as? TabController {
            tabbar.hideTabbar(isHidden: true)
        }
        navigationItem.title = "Notifications"
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationTable.separatorColor = UIColor(rgb: 0xEE5F5B).withAlphaComponent(0.30)
        self.notificationTable.register(UINib(nibName: "NotificationsCell", bundle: nil), forCellReuseIdentifier: "NotificationsCell")
        
        self.notificationTable.delegate = self
        self.notificationTable.dataSource = self
        getNotifications(skip: skip)
    }
    // MARK: - get Notifications
    private func getNotifications(skip: Int){
        let url = "https://beauty-station.appssquare.com/api/Back/notifications?skip=\(skip)"
        print("skip num \(skip)")
        NotificationApi.shared.getHomeData(url: url)
        { [weak self] notification in
            guard let self = self else {return}
            
            self.dataCount = notification?.count ?? 0
            
            self.notificationsList.append(contentsOf: notification ?? [])
            
            if self.notificationsList.isEmpty{
                self.emptyNotificationStackV.isHidden = false
                self.notificationTable.isHidden = true
            }else{
                self.notificationTable.isHidden = false
                self.emptyNotificationStackV.isHidden = true
            }
            print("list count \(self.notificationsList.count)")
            self.notificationTable.reloadData()
        }
    }

}
 // MARK: - Extensions
extension NotificationsVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationsList.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = notificationsList.count - 1

        if (indexPath.row == lastElement) && (dataCount != 0) {
            getNotifications(skip: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = notificationTable.dequeueReusableCell(withIdentifier: "NotificationsCell", for: indexPath) as? NotificationsCell {
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(rgb: 0xFFEEEE)
            cell.selectedBackgroundView = backgroundView
            cell.bodyLabel.text = self.notificationsList[indexPath.row].body
            cell.titleLabel.text = self.notificationsList[indexPath.row].title
            cell.timeLabel.text = self.notificationsList[indexPath.row].date
            if self.notificationsList[indexPath.row].read == 0{
                cell.contentView.backgroundColor = UIColor(rgb: 0xFFEEEE)
            }else{
                cell.contentView.backgroundColor = .white
            }
            return cell
        }
        return UITableViewCell()
    }
  
    
    
}
