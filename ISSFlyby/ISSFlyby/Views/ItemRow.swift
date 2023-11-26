//
//  ItemRow.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/26.
//

import SwiftUI

struct ItemRow: View {
    var date, time, duration: String
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
    ItemRow(date: "2nd Dec", time: "12PM", duration: "50000 seconds")
}
