//
//  HomeView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 10/03/2023.

import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isSearchOpen: Bool = false
    @State  var userLocation: String = ""
    
    
    var body: some View {
        ZStack{
            Image("background2")
                .resizable().opacity(0.8)
            VStack {
               
             
                HStack {
                    Spacer()
                    
                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Text("Change Location")
                            .bold()
                            .font(.system(size: 30))
                    }
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                    }
                    .padding()
                    
                    Spacer()
                }.padding(EdgeInsets(top: 100, leading: 0, bottom: 100, trailing: 0))
                
                Text(userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                    .formatted(.dateTime.year().hour().month().day()))
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
                
                Spacer()
                
                Text("Temp: \((Int)(modelData.forecast!.current.temp))ºC")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                Text("Humidity: \((Int)(modelData.forecast!.current.humidity))%")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                Text("Pressure : \((Int)(modelData.forecast!.current.pressure)) hPg")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                HStack{
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather.first?.icon ?? "")@2x.png"))
                  
                    Text((modelData.forecast?.current.weather.first!.weatherDescription.rawValue)!)
                        .font(.title3)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                Spacer()
            }
        }.background(Color.white).edgesIgnoringSafeArea(.all)
        .onAppear {
            Task.init {
                self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                modelData.userLocation = self.userLocation
            }
            
        }
        
    }
}
