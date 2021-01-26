//
//  ContentView.swift
//  Calebra
//
//  Created by Rohil on 7/23/20.
//  Copyright © 2020 Calebra Inc. All rights reserved.
//
import SwiftUI
import Foundation
import Combine
import CoreLocation

class LocationViewModel: NSObject, ObservableObject{
    
    @Published var userLatitude: Double = 0
    @Published var userLongitude: Double = 0
    
    
    var firstCall = false
    
    private let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}
extension LocationViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        
        if(firstCall == false) {
            currentLocation = locations.last
            firstCall = true
        } else {
            return
        }
    }
}






struct ContentView: View {
    @ObservedObject var locationViewModel = LocationViewModel()
    @State var date = Date()
    
    @State var temp = "--"
    @State var reminderFill = Globals()
    @State var desc = "--"
    
    init() {
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    func getLocation() {
        print(locationViewModel.userLatitude, locationViewModel.userLongitude)
        
        NetworkCalls.getCurrentWeatherData(lat: locationViewModel.userLatitude, long: locationViewModel.userLongitude) { result in
            switch result {
            case .success(let weatherData):
                self.update(weatherData: weatherData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func update(weatherData: WeatherData) {
        DispatchQueue.main.async {
            temp = "\(weatherData.maxTemp) F"
            desc = "\(weatherData.description.capitalized)"
        }
    }
    
    
    
    
    var body: some View {
        //NavigationView {
        VStack {
            Text("Calebra")
                .bold()
                .font(.system(size: 50))
                .frame(alignment: .topLeading)
            
            ZStack {
                Rectangle()
                    .fill(Color(red: 61/255, green: 133/255, blue: 242/255))
                    .frame(height: 140)
                    .cornerRadius(18)
                    .shadow(radius: 4)
                    .padding(10)
                VStack {
                    Text("\(temp)")
                        .font(.system(size: 30))
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("\(desc)")
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            self.getLocation()
            UINavigationBar.appearance().barTintColor = .clear
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        }
        
    }
    // }
    
    /*NavigationView {
     ZStack {
     Rectangle()
     .fill(Color(red: 11/255, green: 28/255, blue: 89/255))
     .edgesIgnoringSafeArea(.all)
     
     Rectangle()
     .fill(Color(red: 14/255, green: 37/255, blue: 120/255))
     .rotationEffect(Angle(degrees: 45))
     .shadow(radius: 6)
     .frame(height: 10000)
     .edgesIgnoringSafeArea(.all)
     
     
     VStack {
     
     Text("Calebra")
     .foregroundColor(.white)
     .font(.system(size: 54))
     .frame(alignment: .topLeading)
     
     ZStack {
     Rectangle()
     .fill(Color.white.opacity(0.45))
     .cornerRadius(12)
     .frame(height: 180)
     .padding(.horizontal)
     .padding(.vertical, 2)
     .shadow(radius: 16)
     VStack {
     //The time of day
     Text("\(timeString(date: date))")
     .bold()
     .font(.system(size: 28))
     .padding(10)
     
     Text("\(self.temp)")
     .bold()
     .padding(.top, 10)
     //.padding(.bottom, 10)
     .frame(alignment: .topLeading)
     .font(.system(size: 48))
     
     
     
     Text("\(self.desc)")
     .font(.system(size: 20))
     .frame(maxWidth: .infinity)
     .padding(.top, 10)
     
     
     
     }
     }
     
     
     
     ZStack {
     Rectangle()
     .fill(Color.white.opacity(0.45))
     .cornerRadius(12)
     .frame(height: 110)
     .padding(.horizontal)
     .padding(.vertical, 2)
     .shadow(radius: 16)
     
     VStack {
     
     Text("Reminders")
     .font(.system(size: 26))
     .bold()
     
     NavigationLink(destination: RemindersView(globals: self.reminderFill)) {
     Text("View Reminders")
     .foregroundColor(Color.init(red: 11/255, green: 28/255, blue: 89/255))
     .bold()
     .padding()
     
     }
     .navigationBarTitle("", displayMode: .inline)
     }
     
     }
     
     ZStack {
     Rectangle()
     .fill(Color.white.opacity(0.45))
     .cornerRadius(12)
     .frame(height: 125)
     .padding(.horizontal)
     .padding(.vertical, 2)
     .shadow(radius: 16)
     
     VStack {
     Text("Settings")
     .font(.system(size: 26))
     .bold()
     
     Text("Get the most of Calebra")
     .padding(.top, 10)
     
     
     NavigationLink(destination: SettingsView()) {
     Text("Customize Settings")
     .foregroundColor(Color.init(red: 11/255, green: 28/255, blue: 89/255))
     .bold()
     .padding()
     }
     }
     }
     }
     
     
     }
     
     }.onAppear {
     self.getLocation()
     UINavigationBar.appearance().barTintColor = .clear
     UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
     }
     }*/
    
    
    
    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH"
        formatter.string(from: date)
        return formatter
    }
    
    
    
    func timeString(date: Date) -> String {
        let hour = Int(timeFormat.string(from: date))!
        var timeOfDay = ""
        
        if(hour >= 0 && hour < 12) {
            timeOfDay = "Good Morning!"
        } else if(hour >= 12 && hour < 17) {
            timeOfDay = "Good Afternoon!"
        } else if(hour >= 17 && hour < 20) {
            timeOfDay = "Good Evening!"
        } else {
            timeOfDay = "Good Night!"
        }
        
        
        
        return timeOfDay
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}


