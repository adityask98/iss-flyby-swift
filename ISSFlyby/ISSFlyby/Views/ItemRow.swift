//
//  ItemRow.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/26.
//

import SwiftUI

struct ItemRow: View {
    var date, time, duration: String
    var data: Item
    @State private var expanded = false
    var body: some View {
        VStack{
        HStack{
            Text(date)
                .foregroundStyle(Color(.white))
            Spacer()
            if expanded {
                Image(systemName: "chevron.up").foregroundStyle(Color(.white))
            } else {
                Image(systemName: "chevron.down").foregroundStyle(Color(.white))
            }
            
        }
            if expanded {
                HStack{
                    Text("At \(time) for \(duration)").foregroundStyle(Color(.white))
                    Spacer()
                }
                Button(action: {
                    print(data)
                    
                }) {
                    HStack {
                        Image(systemName: "calendar.badge.plus")
                        Text("Add to calendar")
                        Spacer()
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12.0)
                .buttonStyle(PlainButtonStyle())
        }
            }
            
        .padding()
        .background(Color("darkPrimaryColor"))
        .onTapGesture {
            expanded.toggle()
        }
    }
}

#Preview {
    ItemRow(date: "2nd Dec", time: "12PM", duration: "50000 seconds", data: Item(title: "2024-02-17 ISS Sighting", description: ISSFlyby.ISSSighting(date: "Saturday Feb 17, 2024 ", time: "6:04 AM ", duration: "4 minutes ", maxElevation: "", approach: "37° above SSW ", departure: "10° above ENE ")))
}
