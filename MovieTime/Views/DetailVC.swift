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
    
    var resultData: ResultModel
    init(resultData: ResultModel) {
        self.resultData = resultData
        super.init(nibName: "DetailVC", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        bottomView.layer.cornerRadius = 9
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 49
        
        backdropImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + (resultData.backdropPath ?? "")))
       
        posterImageView.layer.borderColor = UIColor.white.cgColor
        posterImageView.layer.borderWidth = 3
        posterImageView.layer.cornerRadius = 9
        posterImageView.sd_setImage(with: URL(string: NetworkConstants.shared.imageServerAddress + ((resultData.posterPath ?? resultData.profilePath) ?? "")))
        
        titleLabel.text = resultData.title
        originalTitleLabel.text = resultData.originalTitle
        
        descriptionLabel.text = resultData.overview
        
    }

}
