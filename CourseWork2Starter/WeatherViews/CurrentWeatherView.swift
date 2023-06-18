//
//  Conditions.swift
//  Coursework2
//
//  Created by G Lukka.

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var locationString: String = "No location"
    
    var body: some View {
        ZStack{
            Image("background2")
                .resizable().opacity(0.8)
            VStack {
                
                
                Spacer()
                Text(modelData.userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                
                
                
                
                Text("\((Int)(modelData.forecast!.current.temp))ºC")
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                HStack{
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather.first?.icon ?? "")@2x.png"))
                    
                    Text((modelData.forecast?.current.weather.first!.weatherDescription.rawValue.capitalized)!)
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
                
                HStack{
                    
                    Text("H: \((Int)(modelData.forecast!.current.humidity))ºC")
                        .fontWeight(.bold)
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Text("Low: \((Int)(modelData.forecast!.current.dewPoint))ºC")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                Text("Feel Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                    .padding()
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)

                HStack{
                    
                    Text("Wind Speed: \((Int)(modelData.forecast!.current.windSpeed))m/s")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                    Spacer()
                    Text("Direction: \(  convertDegToCardinal(deg: (Int)(modelData.forecast!.current.windDeg)))")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                
                HStack{
                    
                    Text("Humidity: \((Int)(modelData.forecast!.current.humidity))%")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                    Spacer()
                    Text("Pressure: \((Int)(modelData.forecast!.current.pressure)) hPg")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                HStack{
                HStack{
                    
                    
                    Image(systemName: "sunrise.fill").renderingMode(.original)
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunrise ?? 0))))
                        .formatted(.dateTime.hour().minute().attributed))
                }
                
                HStack{
                    
                    Image(systemName: "sunset.fill").renderingMode(.original)
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunset ?? 0))))
                        .formatted(.dateTime.hour().minute().attributed))
                }
            }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                
             
                Spacer()
                
        }.foregroundColor(.black)
                .fontWeight(.bold)

        }.ignoresSafeArea(edges: [.top, .trailing, .leading])
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(ModelData())
    }
}
