//
//  DetailVC.swift
//  MovieTime
//
//  Created by Eken Özlü on 20.06.2023.
//

import UIKit
import SDWebImage

class DetailVC: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var mediaType: MediaType
    var mediaID: Int
    init(mediaType: MediaType, mediaID: Int) {
        self.mediaType = mediaType
        self.mediaID = mediaID
        super.init(nibName: "DetailVC", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var detailMovie: MovieDetailModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailDataFromAPI()
        
    }
    
    func getDetailDataFromAPI() {
        APICaller.getMovieDetails(withMovieID: mediaID) { result in
            switch result {
            case .success(let success):
                self.detailMovie = success
                self.getMovieCastFromAPI()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getMovieCastFromAPI() {
        APICaller.getMovieCast(withMovieID: mediaID) { result in
            switch result {
            case .success(let success):
                self.detailMovie?.cast = success
                DispatchQueue.main.async {
                    self.configView()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func configView() {
        bottomView.layer.cornerRadius = 9
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 49
        
        backdropImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (detailMovie?.backdropPath ?? "")))
       
        posterImageView.layer.borderColor = UIColor.white.cgColor
        posterImageView.layer.borderWidth = 3
        posterImageView.layer.cornerRadius = 9
        posterImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (detailMovie?.posterPath ?? "")))
        
        titleLabel.text = detailMovie?.title
        originalTitleLabel.text = detailMovie?.originalTitle
        
        //descriptionLabel.text = detailMovie?.overview
        
    }

}
