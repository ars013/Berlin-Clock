//
//  ContentView3.swift
//  HW7
//
//  Created by Арслан on 15.12.2021.
//

import SwiftUI

struct ContentView3: View {

    var rec: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(height: 312)
            .foregroundColor(.white)
    }
    
    var recS: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .foregroundColor(.white)
    }

    var rectangleWidth: CGFloat = 21.0
    var rectangleHeight: CGFloat = 32.0
    var rectangleCornerRadious: CGFloat = 2.0
    var cubeWidth: CGFloat = 74.0
    var cubeHeight: CGFloat = 32.0
    var cubeCornerRadious: CGFloat = 4.0

    @State var berlinDate: [String] = []
    @State var normalClock: String = ""
    
    
    var body: some View {
        ZStack {
            backG3()
            VStack(spacing: 0) {
 
                Text("Time is \(normalClock)")
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                    .padding(.top, 56)
                    .padding(.bottom, 20)
                ZStack {
                    rec
                    VStack(spacing: 16) {
                        if(berlinDate.count>0) {
                            HStack {
                                Circle()
                                    .fill(berlinDate[0] == "Y" ? Color(red: 255/255, green: 204/255, blue: 0/255, opacity: 1) : Color(red: 255/255, green: 224/255, blue: 102/255, opacity: 1))
                                    .frame(width: 56, height: 56)
                            }
                            HStack {
                                ForEach((1..<5)) {i in
                                    RoundedRectangle(cornerRadius: cubeCornerRadious, style: .continuous)
                                        .fill(berlinDate[i] == "R" ? Color(red: 255/255, green: 59/255, blue: 48/255, opacity: 1) : Color(red: 255/255, green: 137/255, blue: 131/255, opacity: 1))
                                        .frame(width: cubeWidth, height: cubeHeight)
                                }
                            }
                            HStack {
                                ForEach((5..<9)) {i in
                                    RoundedRectangle(cornerRadius: cubeCornerRadious, style: .continuous)
                                        .fill(berlinDate[i] == "R" ? Color(red: 255/255, green: 59/255, blue: 48/255, opacity: 1) : Color(red: 255/255, green: 137/255, blue: 131/255, opacity: 1))
                                        .frame(width: cubeWidth, height: cubeHeight)
                                }
                            }
                            HStack {
                                Group {
                                    ForEach((9..<20)) {i in
                                        RoundedRectangle(cornerRadius: rectangleCornerRadious, style: .continuous)
                                        
                                            .fill(berlinDate[i] == "Y" ? Color(red: 255/255, green: 204/255, blue: 0/255, opacity: 1) : (berlinDate[i] == "R" ? Color(red: 255/255, green: 59/255, blue: 48/255, opacity: 1) : (berlinDate[i] == "y" ? Color(red: 255/255, green: 224/255, blue: 102/255, opacity: 1) : Color(red: 255/255, green: 137/255, blue: 131/255, opacity: 1))))
                                        
                                            .frame(width: rectangleWidth, height: rectangleHeight)
                                    }
                                }
                            }
                            HStack {
                                ForEach((20..<24)) {i in
                                    RoundedRectangle(cornerRadius: cubeCornerRadious, style: .continuous)
                                        .fill(berlinDate[i] == "Y" ? Color(red: 255/255, green: 204/255, blue: 0/255, opacity: 1) : Color(red: 255/255, green: 224/255, blue: 102/255, opacity: 1))
                                        .frame(width: cubeWidth, height: cubeHeight)
                                }
                            }
                        }
                    }
                    
                    .onAppear {
                        displayDate()
                    }
                }

                insertT3()
                    .padding(.top, 10)
                Spacer()
            }
            .padding([.leading, .trailing])
            
        }
        
    }
    
    func displayDate() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            let date = Date()
            let calendar = Calendar.current
            let seconds = calendar.component(.second, from: date)
            let minutes = calendar.component(.minute, from: date)
            let hours = calendar.component(.hour, from: date)
            let berlinClock = BerlinClock()
            normalClock = "\(hours):\(minutes):\(seconds)"
            berlinDate = berlinClock.rawBerlinClock(hours, minutes, seconds).map{String($0)}
            print(berlinClock.berlinClock(hours, minutes, seconds))
        }).fire()
    }
    
}


struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}

struct backG3: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .frame(width: 380, height: 830)
            .foregroundColor(Color(red: 242/255, green: 242/255, blue: 238/255, opacity: 1))
    }
}

struct insertT3: View {
    var body: some View {
        ZStack {
            rec
            timePicker
                .environment(\.locale, Locale(identifier: "ru_RU"))
        }
    }
    
    var rec: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .foregroundColor(.white)
    }
    
    @State private var currentDate = Date()
    
    var timePicker: some View {
        VStack {
            DatePicker(selection: $currentDate, displayedComponents: .hourAndMinute) { Text("Insert time")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
            }
            
            .datePickerStyle(.compact)
        }
        .padding([.leading, .trailing])
    }
}


