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

struct LocationPicker: View {
    @EnvironmentObject var locationData: MarkerData
    @State private var searchText: String = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
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
                            showingAlert.toggle()
                            let locationStatus = locationManager.locationStatus
                            switch locationStatus {
                            case .authorizedWhenInUse:
                                alertTitle = "Auth When in Use"
                                alertMessage = "Auth when in use"
                            case .none:
                                print("none")
                            case .some(.notDetermined):
                                alertTitle = "Location is not determined"
                                
                            case .some(.restricted):
                                print("resutricted")
                            case .some(.denied):
                                print("denied")
                            case .some(.authorizedAlways):
                                print("authalways")
                            case .some(_):
                                print("unknows")
                            }
                        } .alert(alertTitle, isPresented: $showingAlert) {
                            Button("OK"){ }
                        } message: {
                            Text(alertMessage)
                        }
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
