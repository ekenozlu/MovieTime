//
//  DetailVC.swift
//  MovieTime
//
//  Created by Eken Özlü on 20.06.2023.
//

import UIKit
import SDWebImage

class DetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // IBOutlets
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var castCrewSegmentedButton: UISegmentedControl!
    @IBOutlet weak var castTableView: UITableView!
    
    //Variables and Init
    var mediaType: MediaType
    var mediaID: Int
    var detailMovie: MovieDetailModel?
    var detailTVSeries: TVSeriesDetailModel?
    var detailPerson: PersonDetailModel?
    init(mediaType: MediaType, mediaID: Int) {
        self.mediaType = mediaType
        self.mediaID = mediaID
        super.init(nibName: "DetailVC", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCells()
        getDetailDataFromAPI()
    }
    
    func configureCells() {
        genreCollectionView.register(UINib(nibName: "GenreCell", bundle: nil), forCellWithReuseIdentifier: "genreCell")
        castTableView.delegate = self
        castTableView.dataSource = self
        castTableView.register(UINib(nibName: "CastCell", bundle: nil), forCellReuseIdentifier: "castCell")
        castTableView.register(UINib(nibName: "SeasonCell", bundle: nil), forCellReuseIdentifier: "seasonCell")
    }
    
    func getDetailDataFromAPI() {
        switch mediaType {
        case .movie:
            APICaller.getMovieDetails(withID: mediaID) { result in
                switch result {
                case .success(let success):
                    self.detailMovie = success
                    self.getCastAndCrewFromAPI()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        case .person:
            APICaller.getPersonDetails(withID: mediaID) { result in
                switch result {
                case .success(let success):
                    self.detailPerson = success
                    self.getCastAndCrewFromAPI()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        case .tv:
            APICaller.getTVDetails(withID: mediaID) { result in
                switch result {
                case .success(let success):
                    self.detailTVSeries = success
                    self.getCastAndCrewFromAPI()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        
    }
    
    func getCastAndCrewFromAPI() {
        switch mediaType {
        case .movie:
            APICaller.getMovieCastAndCrew(withID: mediaID) { result in
                switch result {
                case .success(let success):
                    self.detailMovie?.cast = success.cast
                    self.detailMovie?.cast?.sort(by: { c1, c2 in
                        c1.popularity ?? 0 > c2.popularity ?? 0
                    })
                    self.detailMovie?.crew = success.crew
                    self.detailMovie?.crew?.sort(by: { c1, c2 in
                        c1.popularity ?? 0 > c2.popularity ?? 0
                    })
                    DispatchQueue.main.async {
                        self.configView()
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        case .person:
            APICaller.getPersonCastAndCrew(withID: mediaID) { result in
                switch result {
                case .success(let success):
                    self.detailPerson?.cast = success.cast
                    self.detailPerson?.cast?.sort(by: { c1, c2 in
                        c1.popularity ?? 0 > c2.popularity ?? 0
                    })
                    self.detailPerson?.crew = success.crew
                    self.detailPerson?.crew?.sort(by: { c1, c2 in
                        c1.popularity ?? 0 > c2.popularity ?? 0
                    })
                    DispatchQueue.main.async {
                        self.configView()
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        case .tv:
            APICaller.getTVCastAndCrew(withID: mediaID) { result in
                switch result {
                case .success(let success):
                    self.detailTVSeries?.cast = success.cast
                    self.detailTVSeries?.cast?.sort(by: { c1, c2 in
                        c1.popularity ?? 0 > c2.popularity ?? 0
                    })
                    self.detailTVSeries?.crew = success.crew
                    self.detailTVSeries?.crew?.sort(by: { c1, c2 in
                        c1.popularity ?? 0 > c2.popularity ?? 0
                    })
                    DispatchQueue.main.async {
                        self.configView()
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
    func configView() {
        self.title = detailMovie?.title ?? detailPerson?.name ?? detailTVSeries?.name
        let posterGradientLayer = CAGradientLayer()
        posterGradientLayer.colors = [UIColor.darkGray.cgColor,UIColor.clear.cgColor]
        posterGradientLayer.locations = [0,1]
        posterGradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        posterGradientLayer.endPoint = CGPoint(x: 0.5, y: 0.65)
        posterGradientLayer.frame = backdropImageView.frame
        backdropImageView.layer.insertSublayer(posterGradientLayer, at: 0)
        
        cardView.layer.cornerRadius = 9
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 49
        cardView.layer.borderColor = UIColor(named: "Tinted Purple")?.cgColor
        cardView.layer.borderWidth = 3
        
        posterImageView.layer.borderColor = UIColor(named: "Tinted Purple")?.cgColor
        posterImageView.layer.borderWidth = 3
        posterImageView.layer.cornerRadius = 9
        
        switch mediaType {
        case .movie:
            backdropImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (detailMovie?.backdropPath ?? "")))
            posterImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (detailMovie?.posterPath ?? "")))
            titleLabel.text = detailMovie?.title ?? "No Title Info"
            originalTitleLabel.text = detailMovie?.originalTitle ?? "No Original Name Info"
            runtimeLabel.text = "\(detailMovie?.runtime ?? 0) min"
            ratingLabel.text = (detailMovie?.voteAverage?.formattedValue() ?? "N/A") + "/10"
            releaseDateLabel.text = detailMovie?.releaseDate?.getYearOfTheDate()
            descriptionLabel.text = detailMovie?.overview ?? "No Overview"
            
        case .person:
            posterImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (detailPerson?.profilePath ?? "")))
            titleLabel.text = detailPerson?.name ?? "No Name Info"
            originalTitleLabel.text = detailPerson?.knownForDepartment ?? "No Department Info"
            descriptionLabel.text = detailPerson?.biography ?? ""
        case .tv:
            backdropImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (detailTVSeries?.backdropPath ?? "")))
            posterImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (detailTVSeries?.posterPath ?? "")))
            titleLabel.text = detailTVSeries?.name ?? "Title"
            originalTitleLabel.text = detailTVSeries?.originalName ?? "No Original Name Infp"
            runtimeLabel.text = "\(detailTVSeries?.numberOfEpisodes ?? 0) ep"
            ratingLabel.text = "\(detailTVSeries?.voteAverage ?? 0)/10"
            releaseDateLabel.text = (detailTVSeries?.firstAirDate?.getYearOfTheDate() ?? "N/A") + "-" + (detailTVSeries?.lastAirDate?.getYearOfTheDate() ?? "N/A")
            castCrewSegmentedButton.insertSegment(withTitle: "Season Guide", at: 2, animated: true)
            descriptionLabel.text = detailTVSeries?.overview ?? "No Overview"
        }
        setSegmentedButtonTitles()
        castTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberOfGenres = detailMovie?.genres?.count ?? detailTVSeries?.genres?.count{
            if numberOfGenres == 0 {
                genreCollectionView.isHidden = true
            }
            return numberOfGenres
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCell
        cell.backView.layer.cornerRadius = 20
        cell.genreLabel.text = detailMovie?.genres?[indexPath.row].name ?? detailTVSeries?.genres?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //GO TO GENRE PAGE (SOON)
    }
    
    @IBAction func segmentedControlClick(_ sender: Any) {
        castTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch castCrewSegmentedButton.selectedSegmentIndex {
        case 0:
            return detailMovie?.cast?.count ?? detailTVSeries?.cast?.count ?? detailPerson?.cast?.count ?? 0
        case 1:
            return detailMovie?.crew?.count ?? detailTVSeries?.crew?.count ?? detailPerson?.crew?.count ?? 0
        case 2:
            return detailTVSeries?.seasons?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mediaType == .movie || mediaType == .tv {
            switch castCrewSegmentedButton.selectedSegmentIndex {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "castCell") as! CastCell
                
                cell.backView.layer.cornerRadius = 9
                cell.castImageView.layer.cornerRadius = 9
                guard let cast = detailMovie?.cast?[indexPath.row] ?? detailTVSeries?.cast?[indexPath.row] else {
                    return UITableViewCell()
                }
                cell.castImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (cast.profilePath ?? "")))
                cell.castNameLabel.text = cast.name ?? cast.originalName
                cell.castCharacterLabel.text = cast.character
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "castCell") as! CastCell
                
                cell.backView.layer.cornerRadius = 9
                cell.castImageView.layer.cornerRadius = 9
                guard let crew = detailMovie?.crew?[indexPath.row] ?? detailTVSeries?.crew?[indexPath.row] else {
                    return UITableViewCell()
                }
                cell.castImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (crew.profilePath ?? "")))
                cell.castNameLabel.text = crew.name ?? crew.originalName
                cell.castCharacterLabel.text = crew.job ?? crew.department
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "seasonCell") as! SeasonCell
                cell.backView.layer.cornerRadius = 9
                cell.seasonImageView.layer.cornerRadius = 9
                let season = detailTVSeries?.seasons?[indexPath.row]
                cell.seasonImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (season?.posterPath ?? "")))
                cell.seasonTitle.text = season?.name
                cell.seasonEpCount.text = "\(season?.episodeCount ?? 0) episodes"
                cell.seasonOverview.text = season?.overview
                return cell
            default:
                return UITableViewCell()
            }
        }
        else {
            switch castCrewSegmentedButton.selectedSegmentIndex {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "castCell") as! CastCell
                
                cell.backView.layer.cornerRadius = 9
                cell.castImageView.layer.cornerRadius = 9
                cell.castImageView.contentMode = .scaleAspectFit
                guard let cast = detailPerson?.cast?[indexPath.row] else {
                    return UITableViewCell()
                }
                cell.castImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (cast.posterPath ?? "")))
                cell.castNameLabel.text = cast.title ?? cast.name
                cell.castCharacterLabel.text = cast.character
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "castCell") as! CastCell
                
                cell.backView.layer.cornerRadius = 9
                cell.castImageView.layer.cornerRadius = 9
                cell.castImageView.contentMode = .scaleAspectFit
                guard let crew = detailPerson?.crew?[indexPath.row] else {
                    return UITableViewCell()
                }
                
                cell.castImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (crew.posterPath ?? "")))
                cell.castNameLabel.text = crew.title
                cell.castCharacterLabel.text = crew.job ?? crew.department
                return cell
            default:
                return UITableViewCell()
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch castCrewSegmentedButton.selectedSegmentIndex{
        case 0:
            if mediaType == .movie || mediaType == .tv {
                return 60
            }
            else {
                return 100
            }
        case 1:
            if mediaType == .movie || mediaType == .tv {
                return 60
            }
            else {
                return 100
            }
        case 2:
            return 150
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        castTableView.cellForRow(at: indexPath)?.selectionStyle = .none
        switch castCrewSegmentedButton.selectedSegmentIndex {
        case 0:
            if mediaType == .movie || mediaType == .tv {
                openDetailsVC(.person,
                              (detailMovie?.cast?[indexPath.row].id ??
                               detailTVSeries?.cast?[indexPath.row].id ?? 0))
            }
            else {
                openDetailsVC((detailPerson?.cast?[indexPath.row].mediaType ?? .movie),
                              (detailPerson?.cast?[indexPath.row].id ?? 0))
            }
        case 1:
            if mediaType == .movie || mediaType == .tv {
                openDetailsVC(.person,
                              (detailMovie?.crew?[indexPath.row].id ??
                               detailTVSeries?.crew?[indexPath.row].id ?? 0))
            }
            else {
                openDetailsVC((detailPerson?.crew?[indexPath.row].mediaType ?? .movie),
                              (detailPerson?.crew?[indexPath.row].id ?? 0))
            }
        default:
            break
        }
    }
    
    func openDetailsVC(_ mediaType: MediaType,_ mediaID: Int) {
        let detailsVC = DetailVC(mediaType: mediaType , mediaID: mediaID )
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func setSegmentedButtonTitles() {
        switch mediaType {
        case .movie:
            castCrewSegmentedButton.setTitle("\(detailMovie?.cast?.count ?? 0) Cast", forSegmentAt: 0)
            castCrewSegmentedButton.setTitle("\(detailMovie?.crew?.count ?? 0) Crew", forSegmentAt: 1)
        case .person:
            castCrewSegmentedButton.setTitle("Cast in \(detailPerson?.cast?.count ?? 0)", forSegmentAt: 0)
            castCrewSegmentedButton.setTitle("Crew in \(detailPerson?.crew?.count ?? 0)", forSegmentAt: 1)
        case .tv:
            castCrewSegmentedButton.setTitle("\(detailTVSeries?.cast?.count ?? 0) Cast", forSegmentAt: 0)
            castCrewSegmentedButton.setTitle("\(detailTVSeries?.crew?.count ?? 0) Crew", forSegmentAt: 1)
            castCrewSegmentedButton.setTitle("\(detailTVSeries?.seasons?.count ?? 0) Seasons", forSegmentAt: 2)
        }
    }
}
