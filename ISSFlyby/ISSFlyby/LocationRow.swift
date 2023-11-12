//
//  LocationRow.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/12.
//

import SwiftUI

struct LocationRow: View {
    var locationName: String
    var body: some View {
        HStack {
            Image(systemName: "mappin").foregroundStyle(Color(.white))
            Text(locationName)
                .foregroundStyle(Color(.white))
            Spacer()
            
        }
        .padding()
        .background(Color("darkPrimaryColor"))
    }
}

#Preview {
    LocationRow(locationName: "San Francisco")
}
