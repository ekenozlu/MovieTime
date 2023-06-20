//
//  FirstTabVC.swift
//  MovieTime
//
//  Created by Eken Özlü on 15.06.2023.
//

import UIKit
import SDWebImage

enum MovieListParameter {
    case nowPlaying
    case topRated
    case upcoming
}

class FirstTabVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var trendingMoviesCV: UICollectionView!
    @IBOutlet weak var moviesTV: UITableView!
    @IBOutlet weak var nowPlayingButton: UIButton!
    @IBOutlet weak var topRatedButton: UIButton!
    @IBOutlet weak var upcomingButton: UIButton!
    
    var trendingMoviesArray = [ResultModel]()
    var movieArray = [ResultModel]()
    var movieParameter: MovieListParameter = .nowPlaying
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Time"
        
        getTrendingMoviesFromAPI()
        getMovieListFromAPI()
    }
    
    @IBAction func tapAction(_ sender: UIButton){
        switch sender {
        case nowPlayingButton:
            movieParameter = .nowPlaying
        case topRatedButton:
            movieParameter = .topRated
        case upcomingButton:
            movieParameter = .upcoming
        default:
            break
        }
        getMovieListFromAPI()
    }
    
    func getMovieListFromAPI() {
        movieArray.removeAll()
        var parameterString = ""
        switch movieParameter {
        case .nowPlaying:
            parameterString = "/movie/now_playing"
            nowPlayingButton.tintColor = .systemPurple
            topRatedButton.tintColor = UIColor(named: "Tinted Purple")
            upcomingButton.tintColor = UIColor(named: "Tinted Purple")
        case .topRated:
            parameterString = "/movie/top_rated"
            nowPlayingButton.tintColor = UIColor(named: "Tinted Purple")
            topRatedButton.tintColor = .systemPurple
            upcomingButton.tintColor = UIColor(named: "Tinted Purple")
        case .upcoming:
            parameterString = "/movie/upcoming"
            nowPlayingButton.tintColor = UIColor(named: "Tinted Purple")
            topRatedButton.tintColor = UIColor(named: "Tinted Purple")
            upcomingButton.tintColor = .systemPurple
        }
        
        APICaller.getMovieList(withParameter: parameterString) { [weak self] result in
            switch result {
            case .success(let success):
                self?.movieArray = success.results ?? []
                DispatchQueue.main.async {
                    self?.moviesTV.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getTrendingMoviesFromAPI() {
        APICaller.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let success):
                self?.trendingMoviesArray = success.results ?? []
                DispatchQueue.main.async {
                    self?.trendingMoviesCV.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = trendingMoviesCV.dequeueReusableCell(withReuseIdentifier: "trendingMovieCell", for: indexPath) as! TrendingMoviesCell
        cell.movieBackView.layer.cornerRadius = 9
        cell.movieImage.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (trendingMoviesArray[indexPath.row].posterPath ?? "")))
        cell.movieImage.layer.cornerRadius = 9
        cell.movieNoLabel.text = String(indexPath.row + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // GO TO MOVIE DETAIL PAGE (SOON)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTV.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesCell
        cell.movieImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (movieArray[indexPath.row].posterPath ?? "")))
        cell.movieImageView.layer.cornerRadius = 9
        cell.movieTitle.text = movieArray[indexPath.row].title
        cell.movieSubtitle.text = "\(String(describing: movieArray[indexPath.row].voteAverage))/10"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesTV.cellForRow(at: indexPath)?.selectionStyle = .none
        // GO TO MOVIE DETAIL PAGE (SOON)
        
    }
    
}
