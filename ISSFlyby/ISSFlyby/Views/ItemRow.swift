//
//  ItemRow.swift
//  ISSFlyby
//
//  Created by Aditya Srinivasa on 2023/11/26.
//

import SwiftUI
import AlertToast

struct ItemRow: View {
    var date, time, duration: String
    var data: Item
    
    @State private var expanded = false
    @State private var showSuccessToast = false
    @State private var showConfirmAlert = false
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
                    //print(data)
//                    CalendarEventParser.parseandCreateCalendarEvent(data: data, date: date, time: time)
                    //showSuccessToast.toggle()
                    showConfirmAlert.toggle()
                    
                    
                }) {
                    HStack {
                        Image(systemName: "checklist")
                        Text("Add to reminders")
                        Spacer()
                    }
                }
//                .alert(isPresented: $showConfirmAlert) {
//                    Alert(
//                        title: Text("Add reminder"),
//                        message: Text("This will add an entry to your reminders list. Do you want to continue?"),
//                        primaryButton: .default(Text("Add to reminders"))
//                            .action {
//                                print("Reminder added successfully") // Or handle success/failure appropriately
//                            },
//                        secondaryButton: .cancel()
//                    )
//                }
                
                .alert("Add to reminders", isPresented: $showConfirmAlert, actions: {
                    Button("Add", action: {CalendarEventParser.parseandCreateCalendarEvent(data: data, date: date, time: time)})
                    Button("Cancel", action: {showConfirmAlert.toggle()})
                })
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12.0)
                .buttonStyle(PlainButtonStyle())
        }
            }
       // .alert(Text("Do you want to add to reminders?"), isPresented: $showConfirmAlert, )
        .toast(isPresenting: $showSuccessToast) {
            AlertToast(displayMode: .alert, type:  .regular, title: "SUCCESS")
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
