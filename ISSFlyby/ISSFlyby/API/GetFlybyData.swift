//
//  GetFlybyData.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/26.
//

import Foundation
import Alamofire
import SWXMLHash


class GetFlybyData: ObservableObject {
    @Published var xmlString: String?
    @Published private(set) var fetchedItems = [Item]()
    
    func fetchData(country: String, region: String, city: String) {
        let xmlURL = "https://spotthestation.nasa.gov/sightings/xml_files.cfm?filename=\(country)_\(region)_\(city).xml"
        
        AF.request(xmlURL).responseData {response in
            switch response.result {
            case .success(let data):
                if let xmlString = String(data: data, encoding: .utf8) {
                    let xml = XMLHash.parse(xmlString)
                    for elem in xml["rss"]["channel"]["item"].all
                    {
                        let title = elem["title"].element!.text
                        let desc = elem["description"].element!.text
                        let item = Item(title: title, description: extractSightingInfo(from: desc)!)
                        self.fetchedItems.append(item)
                    }
                }  else {
                    print("failed to convert data to string")
                }
                
            case .failure(let error):
                print("Error fetching XML: \(error)")
                    
            }
        }
    }
}
