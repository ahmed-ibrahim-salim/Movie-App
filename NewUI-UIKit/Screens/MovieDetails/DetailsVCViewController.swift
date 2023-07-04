import UIKit
import Cosmos
import CoreData

class DetailsVCViewController: UIViewController {
    @IBOutlet weak var addtoFav: UIButton!
    
    @IBAction func addtoFavBtn(_ sender: Any) {
        let numOfmov = movies.filter{ $0.value(forKey: "localMovieID") as? Int == DetailsVCViewController.movie?.id}
        if numOfmov.isEmpty {
            addToCoreData()
        }else{
            removefromCoreData(movie: DetailsVCViewController.movie)
        }
    }
    @IBOutlet weak var addToFavBtn: UIButton!
    @IBOutlet weak var watchNowBtn: UIButton!
    @IBOutlet weak var ratingCosmos: CosmosView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var backPic: UIImageView!
    @IBOutlet weak var titllelbl: UILabel!
    static var movie: Result?
    
    let movies = CoreDataModel().fetch(entityName: "MovieEntityCoreData")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
       let _ = CoreDataModel().fetch(entityName: "MovieEntityCoreData")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailsData()
        let favlist = movies.filter{ $0.value(forKey: "localMovieID") as? Int == DetailsVCViewController.movie?.id}
        if favlist.isEmpty {
            self.addtoFav.setImage(UIImage(named: "star"), for: .normal)

        }else{
            self.addtoFav.setImage(UIImage(named: "starfilled"), for: .normal)
        }
    }

    // MARK: - add or remove CoreData
    func removefromCoreData(movie: Result?){
            self.addtoFav.setImage(UIImage(named: "star"), for: .normal)
            let moviesToDelete = movies.filter{
                $0.value(forKey: "localMovieID") as? Int == movie?.id
            }
            for movie in moviesToDelete{
                CoreDataModel().removeFromCoreD(item: movie)
            }
        }
    func addToCoreData(){
        self.addtoFav.setImage(UIImage(named: "starfilled"), for: .normal)
        let movie = CoreDataModel().AddToCoreD(entityName: "MovieEntityCoreData")
        movie.setValue(DetailsVCViewController.movie?.id, forKey: "localMovieID")
        movie.setValue(DetailsVCViewController.movie?.posterPath, forKey: "imageURL")
       
        do{
            try context.save()
            print("Successfully added \(String(describing: DetailsVCViewController.movie?.title)) to fav")
        } catch{
            print("Error adding movie to fav")
        }
    }
    // MARK: - Set VC data
    func setDetailsData(){
        let movie = DetailsVCViewController.movie
        let backdropUrl = URL(string: movie?.backdropPath ?? "")
        let posterUrl = URL(string: movie?.posterPath ?? "")
        self.ratingCosmos.rating = (movie?.voteAverage ?? 1 ) / 2
        self.titllelbl.text = movie?.title
        self.backPic.sd_setImage(with: backdropUrl, completed: nil)
        self.movieImage.sd_setImage(with: posterUrl, completed: nil)
        self.descriptionLbl.text = movie?.overview
        self.watchNowBtn.layer.cornerRadius = 15
        self.movieImage.layer.cornerRadius = 15
        
    }
}
