//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by Robert Whitewick on 05/05/2023.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photoID: String?
    @NSManaged public var title: String?
    @NSManaged public var dateTaken: Date?
    @NSManaged public var remoteURL: URL?
    @NSManaged public var viewCount: Int32

}

extension Photo : Identifiable {

}
