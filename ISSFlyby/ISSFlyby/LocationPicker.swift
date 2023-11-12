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
    @State private var searchText: String = ""
    var body: some View {
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
            
            HStack {
                UITextField            }
            .padding()
            
            
            Spacer()
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background() {
            Color("primaryColor").ignoresSafeArea()
        }
    }
}

#Preview {
    LocationPicker()
}
