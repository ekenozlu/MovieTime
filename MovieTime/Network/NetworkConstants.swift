//
//  NetworkConstants.swift
//  MovieTime
//
//  Created by Eken Özlü on 15.06.2023.
//

import Foundation

class NetworkConstants {
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init(){}
    
    public var apiKey: String {
        get {
            return "188b7cc2a027cbbf38915b398655b0b8"
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var imageServerAddress : String {
        get {
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
    
    public var searchServerAddress : String {
        get {
            return "https://api.themoviedb.org/3/search/multi?query="
        }
    }
    
    public var movieDetailsServerAddrees : String {
        get {
            return "https://api.themoviedb.org/3/movie/"
        }
    }
    
}

//https://api.themoviedb.org/3/search/multi?query=Morgan&api_key=188b7cc2a027cbbf38915b398655b0b8
//https://api.themoviedb.org/3/search/movie?query=Morgan?api_key=188b7cc2a027cbbf38915b398655b0b8
