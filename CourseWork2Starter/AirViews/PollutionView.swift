//
//  PollutionView.swift
//  Coursework2
//
//  Created by Girish Lukka on 30/12/2022.

import SwiftUI

struct PollutionView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        ZStack{
            Image("background")
                .resizable().opacity(0.8)
            VStack {
                
                
                Spacer()
                Text(modelData.userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                
                
                
                
                Text("\((Int)(modelData.forecast!.current.temp))ºC")
                    .fontWeight(.medium)
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                HStack{
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather.first?.icon ?? "")@2x.png"))
                    
                    Text((modelData.forecast?.current.weather.first!.weatherDescription.rawValue.capitalized)!)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                }
                
                
                HStack{
                    
                    Text("H: \((Int)(modelData.forecast!.current.humidity))ºC")
                        .padding()
                        .font(.body)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    Text("Low: \((Int)(modelData.forecast!.current.dewPoint))ºC")
                        .font(.body)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                }
                Text("Feel Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                    .padding()
                    .font(.body)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                    
                    Text("Air Quality Data:")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
            
                HStack{
                    VStack{
                        Image("so2").resizable().frame(width: 50,height: 50)
                        Text("\((Int)(((modelData.air_pollution?.list.first!.components.so2)!)))")
                            .padding()
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .shadow(color: .black, radius: 0.5)
                    }
                    Spacer()
                    VStack{
                        Image("no").resizable().frame(width: 50,height: 50)
                        Text("\((Int)((modelData.air_pollution?.list.first!.components.no)!))")
                            .padding()
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .shadow(color: .black, radius: 0.5)
                    }
                    Spacer()
                    VStack{
                        Image("voc").resizable().frame(width: 50,height: 50)
                        Text("\((Int)((modelData.air_pollution?.list.first!.components.o3)!))")
                            .padding()
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .shadow(color: .black, radius: 0.5)
                    }
                    Spacer()
                    VStack{
                        Image("pm").resizable().frame(width: 50,height: 50)
                        Text("\((Int)((modelData.air_pollution?.list.first!.components.pm10)!))")                            .padding()
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .shadow(color: .black, radius: 0.5)
                    }
                   
                }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                
                
                Spacer()
                
            }.foregroundColor(.black)
                .shadow(color: .black,  radius: 0.5)
            
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])
    }
}
    

