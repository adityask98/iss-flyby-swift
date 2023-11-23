//
//  LocationRow.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/12.
//

import SwiftUI

struct LocationRow: View {
    var location: Marker
    var body: some View {
        HStack {
            Image(systemName: "mappin").foregroundStyle(Color(.white))
            Text(location.name)
                .foregroundStyle(Color(.white))
            Spacer()
            
        }
        .padding()
        .background(Color("darkPrimaryColor"))
    }
}

#Preview {
    LocationRow(location: MarkerData().markers[0])
}
