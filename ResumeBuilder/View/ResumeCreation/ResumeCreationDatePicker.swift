//
//  ResumeCreationDatePicker.swift
//  ResumeBuilder
//
//  Created by Ardak Tursunbayev on 12.03.2025.
//

import SwiftUI

struct ResumeCreationDatePicker : View {
    @Binding var date : Date
    @State var presentDatePicker = false
    let text : String
    var body: some View {
        VStack{
            Button{
                withAnimation {
                    presentDatePicker.toggle()
                }
            } label : {
                HStack{
                    Text(LocalizedStringKey(text))
                        .foregroundColor(Color(hex: "#444444").opacity(0.30))
                    Text(formatDate(date: date))
                        .foregroundColor(Color.black)
                        .font(.system(size: 18, weight: .regular))
                }
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hex:"#F8FBFF"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            if presentDatePicker {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex:"#F8FBFF"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
        }
        
    }
    
}

func formatDate(date : Date) -> String{
    let formatter = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd" // Set the desired format
    let formattedDate = formatter.string(from: date)
    return formattedDate
}

