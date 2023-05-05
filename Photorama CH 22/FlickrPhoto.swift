//
//  Photo.swift
//  Photorama
//
//  Created by Robert Whitewick on 04/05/2023.
//

import Foundation

class FlickrPhoto: Codable{
    let title: String
    let remoteURL: URL?
    let photoID: String
    let dateTaken: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case photoID = "id"
        case dateTaken = "datetaken"
    }
}

extension FlickrPhoto: Equatable {
    static func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
        //Two photos are the same if they have the same photoID
        return lhs.photoID == rhs.photoID
    }
}
