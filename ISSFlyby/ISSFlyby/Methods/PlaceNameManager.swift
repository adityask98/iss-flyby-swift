//
//  PlaceNameManager.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2024/02/06.
//

import Foundation
import CoreLocation
import Combine

class PlaceNameManager: NSObject, ObservableObject {
    //let coordinates: CLLocation?
    @Published var placeName: String?
    
//    init(coordinates: CLLocation?, placeName: String) {
//        self.coordinates = coordinates
//        self.placeName = placeName
//    }
    
    
    func getPlaceName(coordinates: CLLocation, completion: @escaping (String?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(coordinates, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Failed with error" + error!.localizedDescription)
                self.placeName = nil
                return
            }
//            if placemarks!.count > 0 {
//                let pm = placemarks![0] as CLPlacemark
//                print(pm.locality)
//                self.placeName = pm.locality
//            }
            if let placemark = placemarks?.first?.locality {
                self.placeName = placemark
                print("Printing inside Method", placemark)
                completion(placemark)
            } else {
                print("Unknwon")
               completion("Unknwon city")
            }
        })
    }
}
