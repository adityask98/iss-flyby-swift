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
    func setAlertContent(title: String, message: String) {
        alertTitle = title
        alertMessage = message
    }
    
    func handleLocationAlert() {
        if (locationOnOrOff()){
            setAlertContent(title: "Location Status", message: "Location Permission looks okay!")
        } else {
            setAlertContent(title: "Something went wrong", message: "Please check location permissions")
        }
    
    }
        
    func locationOnOrOff() ->  Bool {
        let locationStatus = locationManager.locationStatus
        switch locationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .notDetermined, .denied, .restricted, .none:
            return false
        case .some(_):
            return false
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
                            Task {
                                print(userLatitude)
                               handleLocationAlert()
                                if (locationOnOrOff()) {
                                    placeNameManager.getPlaceName(coordinates: locationManager.lastLocation!) { placeName in
                                        if let placeName = placeName {
                                            searchText = placeName
                                        } else {
                                            print("Failed to retireve inside view")
                                        }
                                    }
                                } else {
                                    showingAlert.toggle()
                                }
                                
                            }

                        }
                        .alert(alertTitle, isPresented: $showingAlert) {
                            Button("OK"){ }
                        } message: {
                            Text(alertMessage)
                        }
                    
                    Image(systemName: "info.circle")
                        .foregroundStyle(.white)
                        .onTapGesture {
                            showModal = true
                        }
                        .JMModal(showModal: $showModal, for: [.location, .calenderWrite, .remindersFull], autoCheckAuthorization: false)
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
