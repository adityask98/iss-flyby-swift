//
//  LocationDetail.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/26.
//

import SwiftUI
import MapKit

struct LocationDetail: View {
    @EnvironmentObject var locationData: MarkerData
    var location: Marker
    
    @State private var region: Binding<MKCoordinateRegion>?
    
    var body: some View {
        ScrollView{
            VStack{
                if let region = region {
                    Map(coordinateRegion: region)
                        .frame(height: 200)
                }
                Text(location.name)
                    .frame(maxWidth: .infinity, alignment: .center )
                    .padding()
                    .foregroundStyle(Color("accentText"))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("darkPrimaryColor")))
               
            }
            .onAppear {
                region = Binding.constant(MKCoordinateRegion(center: .init(latitude: location.latitude, longitude: location.longitude), span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)))
                        }
        }
        .navigationTitle(location.name)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background() {
            Color("primaryColor").ignoresSafeArea()
        }
      
    }
    
    
}

#Preview {
    LocationDetail(location: MarkerData().markers[2])
}
