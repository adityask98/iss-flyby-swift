//
//  LocationPicker.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/12.
//

import SwiftUI

extension Color {
    static let primaryColor = Color("")
}

struct LocationPicker: View {
    @EnvironmentObject var locationData: MarkerData
    @State private var searchText: String = ""
    
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
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
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
