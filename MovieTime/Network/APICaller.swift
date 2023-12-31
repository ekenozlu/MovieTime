//
//  APICaller.swift
//  MovieTime
//
//  Created by Eken Özlü on 15.06.2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller{
    
    //MARK: Trending Callers
    static func getTrendingMovies(completionHandler: @escaping (_ result: Result<CellModel,NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.serverAddress + "trending/movie/week?api_key=" + NetworkConstants.shared.apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(CellModel.self, from: data) {
                completionHandler(.success(resultData))
            }
            else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getMovieList(withParameter parameter: String, completionHandler: @escaping (_ result: Result<CellModel,NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.serverAddress + parameter + "?api_key=" + NetworkConstants.shared.apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(CellModel.self, from: data) {
                completionHandler(.success(resultData))
            }
            else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    //MARK: Search Callers
    static func getResultFromSearch(withQuery query: String, completionHandler: @escaping (_ result: Result<CellModel,NetworkError>) -> Void) {
        let queryString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = NetworkConstants.shared.searchServerAddress + queryString + "&api_key=" + NetworkConstants.shared.apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(CellModel.self, from: data) {
                completionHandler(.success(resultData))
            }
            else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    //MARK: Movie Detail Callers
    static func getMovieDetails(withID id: Int, completionHandler: @escaping (_ result: Result<MovieDetailModel,NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.movieDetailsServerAddrees + String(id) + "?api_key=" + NetworkConstants.shared.apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(MovieDetailModel.self, from: data) {
                completionHandler(.success(resultData))
            }
            else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getMovieCastAndCrew(withID id: Int, completionHandler: @escaping (_ result: Result<MovieDetailModel,NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.movieDetailsServerAddrees + String(id) + "/credits?api_key=" + NetworkConstants.shared.apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
    
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(MovieDetailModel.self, from: data) {
                completionHandler(.success(resultData))
            }
            else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    //MARK: TV Detail Callers
    static func getTVDetails(withID id: Int, completionHandler: @escaping (_ result: Result<TVSeriesDetailModel,NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.tvDetailsServerAddrees + String(id) + "?api_key=" + NetworkConstants.shared.apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(TVSeriesDetailModel.self, from: data) {
                completionHandler(.success(resultData))
            }
            else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getTVCastAndCrew(withID id: Int, completionHandler: @escaping (_ result: Result<TVSeriesDetailModel,NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.tvDetailsServerAddrees + String(id) + "/credits?api_key=" + NetworkConstants.shared.apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
    
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(TVSeriesDetailModel.self, from: data) {
                completionHandler(.success(resultData))
            }
            else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    //MARK: Person Detail Callers
    static func getPersonDetails(withID id: Int, completionHandler: @escaping (_ result: Result<PersonDetailModel,NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.personDetailsServerAddrees + String(id) + "?api_key=" + NetworkConstants.shared.apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(PersonDetailModel.self, from: data) {
                completionHandler(.success(resultData))
            }
            else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getPersonCastAndCrew(withID id: Int, completionHandler: @escaping (_ result: Result<PersonDetailModel,NetworkError>) -> Void) {
        let urlString = NetworkConstants.shared.personDetailsServerAddrees + String(id) + "/combined_credits?api_key=" + NetworkConstants.shared.apiKey
        print(urlString)
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
    
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(PersonDetailModel.self, from: data) {
                completionHandler(.success(resultData))
            }
            else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
}


