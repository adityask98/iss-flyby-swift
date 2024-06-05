//
//  LocationDetail.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/26.
//

import AlertToast
import MapKit
import SwiftUI

struct LocationDetail: View {
  @EnvironmentObject var locationData: MarkerData
  @ObservedObject private var flybyData = GetFlybyData()
  @State private var isDataFetched = false
  @State private var showSuccessToast = false
  var location: Marker

  @State private var region: Binding<MKCoordinateRegion>?

  var body: some View {
    VStack {
      if let region = region {
        Map(coordinateRegion: region)
          .ignoresSafeArea(edges: .top)
          .frame(height: 200)
      }
      Text(location.name)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()

        .foregroundStyle(Color("accentText"))
        .background(RoundedRectangle(cornerRadius: 10).fill(Color("darkPrimaryColor")))

      if !flybyData.fetchedItems.isEmpty {
        List(flybyData.fetchedItems, id: \.self) { item in
          ItemRow(
            date: item.description.date, time: item.description.time,
            duration: item.description.duration, data: item, locationData: location,
            showSuccessToast: $showSuccessToast
          )
          .listRowBackground(Color("darkPrimaryColor"))
        }

        .listStyle(.plain)

      } else {
        ProgressView()
          .tint(Color("accentText"))
        Spacer()
      }
    }
    .toast(isPresenting: $showSuccessToast) {
      AlertToast(
        displayMode: .alert, type: .complete(Color("successGreen")), title: "SUCCESS",
        subTitle: "Reminder Successfully saved")
    }
    .onAppear {
      if !isDataFetched {
        region = Binding.constant(
          MKCoordinateRegion(
            center: .init(latitude: location.latitude, longitude: location.longitude),
            span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)))
        flybyData.fetchData(
          country: location.country, region: location.additional_info,
          city: location.city_identifier)
        UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = .dark
        isDataFetched = true
      }
    }

    .navigationTitle(location.name)
    .navigationBarTitleDisplayMode(.inline)
    .toolbarBackground(Color("primaryColor"), for: .navigationBar)
    .ignoresSafeArea(edges: .top)
    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity /*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    .background {
      Color("primaryColor").ignoresSafeArea()
    }

  }

}

#Preview {
  LocationDetail(location: MarkerData().markers[2])
}
