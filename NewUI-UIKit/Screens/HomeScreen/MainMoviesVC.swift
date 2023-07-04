//
//  MainMoviesVC.swift
//  NewUI-UIKit
//
//  Created by ahmadibrahim on 12/22/21.
//

import UIKit
import SDWebImage


class MainMoviesVC: UIViewController {
    
    @IBOutlet weak var upcomingLbl: UILabel!
    @IBOutlet weak var topRatedLbl: UILabel!
    @IBOutlet weak var popularLbl: UILabel!
    
    @IBOutlet weak var topratedCollectionV: UICollectionView!
    @IBOutlet weak var popularCView: UICollectionView!
    @IBOutlet weak var upComingCVIew: UICollectionView!
    
    var topRated: [Result]?
    var popular: [Result]?
    var upcoming: [Result]?
    
    var systemLanguage: NSString?
    
    var afterfirstloadTopRated = false
    var afterfirstloadPopular = false
    var afterfirstloadUpcoming = false
    
    var topRatedPageNum = 0
    var popularPageNum = 0
    var upcomingPageNum = 0
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        systemLanguage = Bundle.main.preferredLocalizations.first as NSString?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionV()
        setHomePageStrings()
        setSettingsButton()
    }
    
    func setSettingsButton(){
        let image = UIImage(named: "TBHomeIcon")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsButtonAction))
        
    }
    
    func setHomePageStrings(){
        self.navigationItem.title = "Homepage".localized
        self.popularLbl.text = "Popular Movies".localized
        self.upcomingLbl .text = "Upcoming Movies".localized
        self.topRatedLbl .text = "Top Rated Movies".localized
    }
    
    func setCollectionV() {
        topratedCollectionV.delegate = self
        popularCView.delegate = self
        upComingCVIew.delegate = self
        popularCView.dataSource = self
        upComingCVIew.dataSource = self
        topratedCollectionV.dataSource = self
        //        if Locale.preferredLanguages.first == "ar"{
        //        }
        //        self.setMoviesLists(listType: "top_rated")
        //        self.setMoviesLists(listType: "popular")
        //        self.setMoviesLists(listType: "upcoming")
    }
    
    //  MARK: Network
    
    func setMoviesLists(listType: String, page: Int = 1){
        
        if page == 1{
            if listType == "popular"{
                self.afterfirstloadPopular = !self.afterfirstloadPopular
            }else if listType == "top_rated"{
                self.afterfirstloadTopRated = !self.afterfirstloadTopRated
            }else if listType == "upcoming"{
                self.afterfirstloadUpcoming = !self.afterfirstloadUpcoming
            }
        }
        
        let baseURL = "https://api.themoviedb.org/3/movie/"
        let apiKey = "80adae09b523d3037018900367438854"
        let imagebaseURL = "https://image.tmdb.org/t/p/w500/"
        
        MovieApi.shared.getHomeData(url:
                                        "\(baseURL)\(listType)?api_key=\(apiKey)&page=\(page)"){
            Result in
            var movieArra: [Result] = Result ?? []
            var index = 0
            
            for movie in movieArra{
                let newimageurl = imagebaseURL + (movie.posterPath ?? "")
                let newBackImage = imagebaseURL + (movie.backdropPath ?? "")
                movieArra[index].posterPath = newimageurl
                movieArra[index].backdropPath = newBackImage
                index += 1
            }
            
            if listType == "top_rated"{
                if page != 1 {
                    self.topRated?.append(contentsOf: movieArra)
                }else {
                    self.topRated = movieArra
                }
                self.topratedCollectionV.reloadData()
            } else if listType == "popular"{
                if page != 1 {
                    self.popular?.append(contentsOf: movieArra)
                }else {
                    self.popular = movieArra
                }
                self.popularCView.reloadData()
                
            }else if listType == "upcoming"{
                if page != 1 {
                    self.upcoming?.append(contentsOf: movieArra)
                }else {
                    self.upcoming = movieArra
                }
                self.upComingCVIew.reloadData()
                
            }
            
        }
    }
    // MARK: - Top Right Button Action
    @objc func settingsButtonAction(){
        let sb = UIStoryboard(name: "MoviesMain", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "settingsvc") as? MovieSettingsVC ?? UIViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
// MARK: - Extensions
extension MainMoviesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var listCount = 0
        
        if collectionView == topratedCollectionV {
            listCount = self.topRated?.count ?? 1
        }else if collectionView == popularCView {
            listCount = self.popular?.count ?? 1
        }else if collectionView == upComingCVIew {
            listCount = self.upcoming?.count ?? 1
        }
        
        return listCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCVCell
        if collectionView == topratedCollectionV {
            let url = URL(string: topRated?[indexPath.row].posterPath ?? "" )
            cell.movImage?.sd_setImage(with: url, completed: nil)
        }else if collectionView == popularCView {
            let url = URL(string: popular?[indexPath.row].posterPath ?? "" )
            cell.movImage?.sd_setImage(with: url, completed: nil)
        }else if collectionView == upComingCVIew {
            let url = URL(string: upcoming?[indexPath.row].posterPath ?? "" )
            cell.movImage?.sd_setImage(with: url, completed: nil)
        }
        
        cell.movImage.layer.cornerRadius = 15
        cell.contentView.layer.shadowRadius = 1.0
        cell.contentView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.contentView.layer.shadowOpacity = 1
        //        cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.height)
    }
    
    // MARK: didSelectItem
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "MoviesMain", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "detailsvc") as? DetailsVCViewController ?? UIViewController()
        if collectionView == topratedCollectionV {
            DetailsVCViewController.movie = topRated?[indexPath.row]
        }else if collectionView == popularCView {
            DetailsVCViewController.movie = popular?[indexPath.row]
            
        }else if collectionView == upComingCVIew {
            DetailsVCViewController.movie = upcoming?[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK:  Pagination
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == topratedCollectionV {
            if self.systemLanguage == "ar"{
                if (indexPath.row == 19) && afterfirstloadTopRated{
                    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: false)
                    print("did scroll")
                    self.afterfirstloadTopRated = false
                }else if indexPath.row == (topRated?.count ?? 1) - 1 && !afterfirstloadTopRated{
                    topRatedPageNum += 1
                    setMoviesLists(listType: "top_rated", page: topRatedPageNum)
                    collectionView.scrollToItem(at: IndexPath(item: indexPath.row - 19, section: 0), at: .right, animated: false)
                }
            }else if self.systemLanguage == "en"{
                if indexPath.row == (topRated?.count ?? 1) - 1 {
                    topRatedPageNum += 1
                    setMoviesLists(listType: "top_rated", page: topRatedPageNum)
                }
            }
            
        }else if collectionView == popularCView {
            if self.systemLanguage == "ar"{
                if (indexPath.row == 19) && afterfirstloadPopular{
                    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: false)
                    print("did scroll")
                    self.afterfirstloadPopular = false
                }else if indexPath.row == (popular?.count ?? 1) - 1 && !afterfirstloadPopular{
                    popularPageNum += 1
                    setMoviesLists(listType: "popular", page: popularPageNum)
                    collectionView.scrollToItem(at: IndexPath(item: indexPath.row - 19, section: 0), at: .right, animated: false)
                }
            }else if self.systemLanguage == "en"{
                if indexPath.row == (popular?.count ?? 1) - 1 {
                    popularPageNum += 1
                    setMoviesLists(listType: "popular", page: popularPageNum)
                }
            }
        }else if collectionView == upComingCVIew {
            if self.systemLanguage == "ar"{
                if (indexPath.row == 19) && afterfirstloadUpcoming{
                    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: false)
                    print("did scroll upcoming")
                    self.afterfirstloadUpcoming = false
                }else if indexPath.row == (upcoming?.count ?? 1) - 1 && !afterfirstloadUpcoming{
                    upcomingPageNum += 1
                    setMoviesLists(listType: "upcoming", page: upcomingPageNum)
                    collectionView.scrollToItem(at: IndexPath(item: indexPath.row - 19, section: 0), at: .right, animated: false)
                }
            }else if self.systemLanguage == "en"{
                if indexPath.row == (upcoming?.count ?? 1) - 1 {
                    upcomingPageNum += 1
                    setMoviesLists(listType: "upcoming", page: upcomingPageNum)
                }
            }
        }
        
    }
    
}
