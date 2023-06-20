//
//  SecondTabVC.swift
//  MovieTime
//
//  Created by Eken Özlü on 15.06.2023.
//

import UIKit

class SecondTabVC: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    let searchVC = UISearchController(searchResultsController: nil)
    
    var searchResultsArray = [ResultModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Movies"
        
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Reload Array and TV
        APICaller.getResultFromSearch(withQuery: searchText) { [weak self] result in
            switch result {
            case .success(let success):
                self?.searchResultsArray = success.results ?? []
                DispatchQueue.main.async {
                    self?.searchTableView.reloadData()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        var photoPath = ""
        if let posterPath = searchResultsArray[indexPath.row].posterPath {
            photoPath = posterPath
        }
        if let profilePath = searchResultsArray[indexPath.row].profilePath {
            photoPath = profilePath
        }
        cell.cellImagaView.sd_setImage(with: URL(string: (NetworkConstants.shared.imageServerAddress + photoPath)))
        cell.cellTitle.text = searchResultsArray[indexPath.row].title ?? searchResultsArray[indexPath.row].name
        cell.cellSubtitle.text = searchResultsArray[indexPath.row].mediaType?.rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Details VC
        searchTableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }
    
    
}
