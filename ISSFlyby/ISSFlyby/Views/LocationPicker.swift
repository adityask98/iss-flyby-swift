//
//  LocationPicker.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/12.
//

import SwiftUI
import CoreLocation
import PermissionsSwiftUI
import Locations

extension Color {
    static let primaryColor = Color("")
}

//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    let locationManager = CLLocationManager()
//    @Published var location: CLLocationCoordinate2D?
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.requestAlwaysAuthorization()
//    }
//    func requestLocation(_ manager: CLLocationManager) {
////        switch CLLocationManager.authorizationStatus() {
////        case .notDetermined, .denied, .restricted:
////            print("No access :(")
////        case .authorizedAlways:
////            print("ALWAYS")
////        case .authorizedWhenInUse:
////         print ("WHEN IN USE")
////        @unknown default:
////            print(">???")
////        }
//        //manager.requestWhenInUseAuthorization()
//        
//        //manager.requestLocation()
//        //locationManagerDidChangeAuthorization(locationManager)
//        let accuracyAuthorization = manager.accuracyAuthorization
//        if accuracyAuthorization == CLAccuracyAuthorization.reducedAccuracy {
//            print("REDUCED ACCURACY");
//        }
//        else if accuracyAuthorization ==  CLAccuracyAuthorization.fullAccuracy {
//            print("FULL ACCURACY");
//        }
//    }
//}

struct LocationPicker: View {
    @EnvironmentObject var locationData: MarkerData
    @State private var searchText: String = ""
    
    @StateObject var locationManager = LocationManager()
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    @StateObject var placeNameManager = PlaceNameManager()
    @State var showModal = false
    func getLocation() async {
        let locator: Locater = .init(accuracy: .tenMetres)
        do {
            let stream: AsyncStream<CLLocation> = try locator.subscribe()
            for await data in stream {
                print(data)
            }
        } catch let error {
            print(error)
        }
    }
        
    
    
    var filteredLocations: [Marker] {
        if searchText.isEmpty {
            return locationData.markers
        } else {
            return locationData.markers.filter{$0.name.lowercased().contains(searchText.lowercased())}
        }
    }
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Text("Select your location to continue")
                        .frame(maxWidth: .infinity, alignment: .center )
                        .padding()
                        .foregroundStyle(Color("accentText"))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("darkPrimaryColor")))
                    
                    
                }
                .padding()
                
                HStack {
                    TextField("Filter", text: $searchText)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .foregroundStyle(Color("placeholderText"))
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("darkPrimaryColor")))
                    
                    Image(systemName: "location")
                        .foregroundColor(.white)
                        .onTapGesture {
                           //showModal=true
                            Task {
                                print(userLatitude)
                                //print(locationManager.$lastPlacemarkerName)
                                placeNameManager.getPlaceName(coordinates: locationManager.lastLocation!) { placeName in
                                    if let placeName = placeName {
                                        print("Insisde View", placeName)
                                        searchText = placeName
                                    } else {
                                        print("Failed to retireve inside view")
                                    }
                                }
                                
                            }

                        }.JMModal(showModal: $showModal, for: [.location])
                    
                    Image(systemName: "location")
                        .onTapGesture {
                            print(locationManager.statusString)
                        } .JMAlert(showModal: $showModal, for: [.location])
                }
                .padding()
                Spacer()
                
                
                List(filteredLocations, id: \.self) { location in
                    NavigationLink(destination: LocationDetail(location: location)) {
                        LocationRow(location: location)
                    }
                    .listRowBackground(Color("darkPrimaryColor"))
                }
                .listStyle(.plain)
                
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background() {
                Color("primaryColor").ignoresSafeArea()
            }
        }}
}

#Preview {
    LocationPicker().environmentObject(MarkerData())
}
